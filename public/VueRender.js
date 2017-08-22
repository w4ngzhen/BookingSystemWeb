function sendData(onep,tableId){
	var wrap = {
		startTime: onep.startTime,
		endTime: onep.endTime,
		user: onep.user,
		tableId: tableId
	};
	var str = JSON.stringify(wrap);
	var returnMessage = '';//存储返回信息
	if(!onep.user.name) {
		alert ("请输入用户名等必不可少的信息!!");
		return ;
	}
	//ajax
	return new Promise(function (resolve,reject){
		console.log("zhixingle");
		$.ajax({
			url: '/reservation',
			type: 'post',
			data: {reservation: str},
			success: function (message) {
				returnMessage = message;
				if(returnMessage == 'ok'){
					resolve();
					console.log('ok');
				}else if(returnMessage == 'exist'){
					reject();
					alert('用户已存在');
				}
			}
		});
	});
}
var DocRender= {};
var ItemsMes = new Vue ({
	el:"#itemMes",
	data:{
		items: {
			name : {value:"",text:"用户名"},
			phoneNumber:{value:"",text:"电话号码"},
			email : {value:"",text:"邮箱"}
		},
		user:{
			name :"",
			phoneNumber:"",
			email : ""
		},
		onep:{},
		tableId : ""
	},
    methods:{
        setItem(onep,tableId){
        	this.user  = onep.user;
        	this.onep = onep;
        	this.tableId = tableId;
            // this.items.name.value=onep.user.name;
            // this.items.phoneNumber.value=onep.user.phoneNumber;
            // this.items.email.value=onep.user.email;
        },
        click(){
        	var self = this;
        	sendData(this.onep,this.tableId)
        		.then(function (){
        			self.onep.arg.click = 0;
        			alert("Update is ok!!");
        		});
        },
        getTime(){
        	return this.onep.startTime + "~" +　this.onep.endTime
        }
    }
})
var Onemes = new Vue({
	el: '#form',
	data: {  //vue only view the aall change when v-model change ;
		items: {
			name : {value:"",text:"用户名"},
			phoneNumber:{value:"",text:"电话号码"},
			email : {value:"",text:"邮箱"}
		},
        message:"登录"
	},
	methods:{
		setSubmmit(callback,mes){
			var items = this.items;
            items.name.value ="";
            items.phoneNumber.value = "";
            items.email.value = "";
            this.message = mes||"填写信息";
			this.click = function (event){
				event.preventDefault();
				callback(items);
			}
		},
		click(e){
			event.preventDefault(e);
            console.log(e);
		},
        checkName(){
            if(this.items.name.value == "root" ){
                alert ("当前以 管理员 身份登录！");
            }
        }
	}
})
Vue.component('timebar',{
	template:`
		<div :class = "'timebar '+ (title ?'mytip':'')+(select?'':' toSelect')" 
            v-on:mouseover="$emit('mouseover')"
            v-on:mouseout="$emit('mouseout')"
            v-on:click="$emit('click')"
            >
			<span v-on:click="$emit('remove')" :class=' title ? "quxiao":"none" '>x</span>
		</div>
	`,
	methods:{
		notice(e){
			if( confirm("Are you sure?") ){
				this.$emit('remove');
			}
		},
	},
	props :['title','select']
})
var viewer = "";
var Bkresult = new Vue({
	el:"#bookingResult",
	data:{
		result:{
			"1":[
					// { arg:{show:true},startTime:6.5 ,endTime:8.5,user :{name:"",phoneNumber:"...NULL..",email:""} },
					// { arg:{show:true},startTime:8.5 ,endTime:9,user:{name:"LiuMiao",phoneNumber:"",email:""}},
			],
			"2":[],
			"3":[],
			"4":[],
			"5":[],
		},
	},
	methods:{
		clear(){
			for (var x in  this.result){
				this.result[x] = [];
			}
		},
		addOnep(t,onep){
			if( this.result[t] == undefined ) {
				this.result[t]=[];
			}
			this.result[t].push(onep);
		},
        getName(onep){
            if(onep.user.name) return onep.user.name;
            else{
                return "..NULL.."
            }
        },
		formTime(t){
			var hour = Math.floor(t);
			if(t- hour == 0){
				mi = "00";
			}else{
				mi = (t-hour)*60;
			}
			return hour+":"+mi;
		},
		getTime(onep){
			return this.formTime(onep.startTime)+"--" +this.formTime(onep.endTime);
		},
		comfirmResult(){
			var ret = [];
			var result = this.result;
			var onep={};
			for (var i in result){
				for (var j in result[i]){
					if(result[i][j].arg.show){
						onep = {tableId:i,startTime:result[i][j].startTime,endTime:result[i][j].endTime,user:viewer}
						ret.push(onep);
					}
				}
			}
			console.log(ret);
			return ret;
		},
		getPrice(onep){
			return (-onep.startTime+onep.endTime)*15
		}
	}
})

var Bktable = new Vue ({
	el:"#bktable",
	data:{
		viewer:viewer,
		desk:{
			"1":[
				// { arg:{hover:0,show:true,select:1,click:0},startTime:6.5 ,endTime:8.5,user :"idd" },
				// { arg:{hover:0,show:true,select:1,click:0},startTime:8.5 ,endTime:9,user:{name:"LiuMiao"}},
			],
			"2":[
				// { arg:{hover:0,show:true,select:1,click:0},startTime:14.5 ,endTime:16 ,user:"" },
				// { arg:{hover:0,show:true,select:1,click:0},startTime:11 ,endTime:12 ,user:"" },
			],
			"3":[],
			"4":[
			// {arg:{hover:0,show:true,select:1,click:0},startTime:18 ,endTime:20 ,user:""}
			],
			"5":[],
		},
	},
	methods:{
		clear(){
			for (var x in this.desk){
				this.desk[x] = [];
			}
		},
		getMessage (arr){
			for (x in arr ){
				var onep = {
					arg:{hover:0,show:true,select:1,click:0,tableId:arr[x].tableId},
					startTime : arr[x].startTime,
					endTime : arr[x].endTime,
					user :{
						name :arr[x].user.name,
						phoneNumber:arr[x].user.phoneNumber,
						email:arr[x].user.email
					}
				};
				this.desk[arr[x].tableId].push(onep);
				Bkresult.addOnep(arr[x].tableId,onep);
			}
		},
		getData(obj){
			Bkresult.clear();
			this.clear();
			for (var x in obj){
				this.getMessage(obj[x].message);
			}
		},
		getStyle(x){
			var s=x.startTime, e=x.endTime, p=x.arg.hover||x.arg.click;
			var padding,left,width;
			padding = 4 ;
			left = (s - 5.5)*6.25*12+2+padding;
			width = (e - s)*6.25*12 - 2*padding;
			var tstyle="";
			tstyle = "left:"+left + "px;width:" +　width+"px;";
			if (!p){
				return tstyle;
			}
			if(p){
				var r = 1 + 2*padding/width;
				tstyle +=  "transform:scale(" + r + ",1);";
                if(x.arg.click){
                     tstyle+="background :#70c770;"
                }
			}
			return tstyle;
		},
        clickOnce(x){
            var c = x.arg.click;
            if(c == 0){
                console.log(x.user);
                ItemsMes.setItem(x,x.arg.tableId);
            }
            x.arg.click = c^1;
            if(x.arg.click  == 1 && Tool.TempStore.lastClick && Tool.TempStore.lastClick !=x){
                Tool.TempStore.lastClick.arg.click = 0;
            }
            Tool.TempStore.lastClick = x; //to avoid the Vue watch;
        },
		drawSelect(e){
			console.log(e.target);
		},
		checkTime(i,s,e,onep){
			for (var x of this.desk[i]){
				if(x == onep) continue;
				if(x.arg.show && x.startTime <= s && !(x.endTime<= s)) return false;
				if(x.arg.show && x.startTime >= s && !(x.startTime >= e) ) return false;
			}
			return true;
		},
		cancel(x,id){
			x.arg.show = false;
			alert('cancel is ok');
			var wrap = {
				startTime: x.startTime,
				endTime: x.endTime,
				user: x.user,
				tableId: id
			};
			var str = JSON.stringify(wrap);
			// ajax
			$.ajax({
				type: 'post',
				url: '/cancel',
				data: {cancel: str},
				success: function (str) {
					console.log(str);
				}
			})
			
		}
	}
});
// $('#ttttt').click(function () {
// 	$.ajax({
// 		type: 'post',
// 		url: '/date',
// 		data: {'year': 2017,'month': 1,'day': 1},
// 		success: function () {
// 			console.log('ok');
// 		}
// 	});
// });
var Main = {
    data() {
      return {
        pickerOptions0: {
          disabledDate(time) {
            return time.getTime() < Date.now() - 8.64e7;
          }
        },
        date: ""
      };
    },
    watch: {
    	date: function () {
    		if(this.date){
    			var year = this.date.getFullYear()
    			var month = this.date.getMonth() + 1
    			var day = this.date.getDate()
    		}
    		var date = JSON.stringify({year, month, day});
    		$.ajax({
    			type: 'post',
    			url: '/date',
    			data: {date},
    			success: function (tables) {
    				Bktable.getData(tables);
    				console.log(tables, 'ok');
    			}
    		})
    	}
    }
};
var Ctor = Vue.extend(Main)
new Ctor().$mount('#datepicker').date = new Date();