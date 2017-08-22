initMove(".login");
var Login = initShower('.background','.login');  // all of the dom oparation should be after the Vue!!;
// Login.show(500);
// Login.close();
Onemes.setSubmmit(function (){
    Onemes.checkName();
    Login.close();
},"登录");
$('.background').on("mousedown",Login.close);
var downTime = 0;
$(".selectWrap").on("mousedown",function (e){
	var col = $(e.target).closest(".select-bar")
	if ( col[0] ){
//		console.dir(col[0]);
//		console.dir(this);
	}else{
		return; 
	}
	var start = +col[0].dataset.num;
	var end;
	function tooMuch(){
		alert ("只可一次预定 3小时");
	}
	function selectMore(e){
		var col = $(e.target).closest(".select-bar")
		if ( col[0] ){
//			console.log(col[0]);
//			console.log(this);
		}else{return ;}
		end  = +col[0].dataset.num;
//		if(Math.abs(end - start)>5) {
////			tooMuch();
//			return ;
//		}
		var s,e;
		if(end  >  start){
			s = (start - 2)*0.5 + 6;
			e = (end - 2)*0.5 + 6.5
		}else{
			s = (end - 2)*0.5 + 6;
			e = (start -2)*0.5 + 6.5;
		}
		if(! Bktable.checkTime(this.dataset.deskid,s,e,onep)) return;
		onep.startTime = s;
		onep.endTime = e;
	}
	if(this.downTime) this.downTime = 1;
	else this.downTime = 0;
	switch(this.downTime){
		case 0:
			var table_id = this.dataset.deskid;
			var onep = {arg:{click:0,hover:0,show:true,select:0,tableId:table_id},startTime:(start - 2)*0.5 + 6,endTime:(start-2 )*0.5 + 6.5,user:{name:Bktable.viewer}};
			if( !Bktable.checkTime(this.dataset.deskid,onep.startTime,onep.endTime,onep) ) return ;
			Bktable.desk[this.dataset.deskid].push(onep);
			Bkresult.addOnep(this.dataset.deskid,onep);
			this.style.zIndex = 30;
			this.onep=onep;
			this.downTime = 1;
			this.addEventListener("mouseover",selectMore);
			this.selectMore = selectMore;
			return ;
		case 1:
//			onep.arg.select = 1;
			this.downTime = 0; 
			this.style.zIndex = 8;
			var onep = this.onep;
			console.log(this.onep,this);
			self = this;
			function setUser(doc){
				onep.user={
					name : doc.name.value,
					phoneNumber:doc.phoneNumber.value,
					email:doc.email.value
				}
				Login.close(); 
				if(onep.user.name) sendData(onep,self.dataset.deskid);
				console.log(onep);
			}
			onep.arg.select = 1;
			Onemes.setSubmmit(setUser);
//			console.log(Bktable.desk);
			Login.show(500,function (){
				Login.select('name');
			});
			this.removeEventListener("mouseover",this.selectMore);
			return ;
	}
})

