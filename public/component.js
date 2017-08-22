function initEnterFace($container,doc_model){
	doc_model || ( doc_model={innerHTML:""} );
	function setContent(innerHTMLstr){
		that.$doc.find(".content").html( innerHTMLstr );
	}
	function start_move(e){
		window.addEventListener("mousemove",move_enterface,false);
		window.addEventListener("mouseup",end_move,false);
		that.mouse={x:e.clientX,y:e.clientY};
//		set_active(that);
	}
	function end_move(e){
		var top=that.doc.offsetTop;
		var left=that.doc.offsetLeft
		that.doc.style.left=(that.doc.offsetLeft+that.position.x)+"px";
		that.doc.style.top=(that.doc.offsetTop+that.position.y)+"px";
		if(that.position.y+top<0){
			that.doc.style.top=0;
		}
		if(that.position.x+left+that.doc.offsetWidth-30<0){
			that.doc.style.left=0;
		}
		if(that.position.x+left+30>window.innerWidth){
			that.doc.style.left=window.innerWidth-that.doc.offsetWidth + "px";
		}
		if(that.position.y+top>window.innerHeight){
			that.doc.style.top=window.innerHeight-that.doc.offsetHeight + "px";
		}
		that.position.x=0;that.position.y=0;
		that.doc.style.transform="";
		window.removeEventListener("mousemove",move_enterface,false);
	}
	function move_enterface(e){
		e.preventDefault();
		that.position.x += e.clientX-that.mouse.x;
		that.position.y += e.clientY-that.mouse.y;
		that.doc.style.transform="translate("+ that.position.x +"px, "+ that.position.y +"px )";
//		if(is_show){
//			that.style.left=left+"px";
//		}
		that.mouse.x=e.clientX;
		that.mouse.y=e.clientY;
	}
	function create_enterface(){
		that.doc=document.createElement('div');
		that.doc.className="enterface";
		that.$doc = $(that.doc);
		that.$doc.hide();
		that.$doc.html(doc_model.innerHTML);
		$container.append(that.doc);
		that.$doc.on("mousedown",".windowtop",start_move);
		that.$doc.on("click",".closebutton",close_enterface);
		Arg.$content=that.$doc.find(".content");
		Arg.$topmessage=that.$doc.find(".topmessage");
	}
	function show_enterface(){
		that.doc.style.left=window.innerWidth/10 +"px";
		that.doc.style.top=window.innerHeight/20 +"px";
		that.position.x=0;that.position.y=0;
		
		that.$doc.show();
		$container.show();
		$("#background").fadeIn(500);
	}
	function close_enterface(){
		that.$doc.hide();
		$container.hide();
		$("#background").fadeOut(500);
	}
	var Arg={
		show:show_enterface,
		close:close_enterface,
		setContent:setContent,
	}
	var that={
		doc:null,
		mouse:{
			x:0,
			y:0,
		},
		position:{
			x:0,y:0
		}
	};
	create_enterface();
	return Arg;
}
function Point(name,par){
	var Arg={name,x:0,y:0}; //内部对象
	var FuncKu={
		setBy(one){
			Arg.x = one.x;
			Arg.y = one.y;
		},
		diffTo(one){
			return {
				x : one.x - Arg.x,
				y : one.y - Arg.y,
			};
		},
		addBy(one){
				Arg.x += one.x;
				Arg.y += one.y;
		},
		multiplyBy(one){
			Arg.x *= one.x ;
			Arg.y *= one.y ;
		}
	};
	var Func = {
		toString(){
			return  "Point of "+Arg.name + (par?" "+par:"") + " is: ("+ Arg.x +","+ Arg.y+")\n" ;
		},
		toTransform(){
			//小数残影.Arg 本值不可变;
			return { 
				transform:"translate("+ Math.round(Arg.x) +"px, "+ Math.round(Arg.y) +"px )"
			};
		},
		toStyle(diff){
			return {
				left : Arg.x + diff.x + "px",
				top : Arg.y + diff.y + "px"
			}
		}
	}
	function Suan(waystr,x,y){
		switch (true){
			case typeof x !=="object" :
				if(x!==undefined&&y!==undefined){
					return FuncKu[waystr]({x,y});
				}
				return ;
			case par !==undefined :
				return Suan(waystr,x[par+"X"],x[par+"Y"]);
		}
		return Suan(waystr,x.x,x.y) ;
	}
	function initFunc(){
		for(let fx in FuncKu){
			ret[fx]=function (x,y){
				return Suan(fx,x,y);
			}
		}
		for ( let fx in Func){
			ret[fx] = Func[fx];
		}
	}
	var ret = {
		get length(){
			return Math.sqrt( Arg.x*Arg.x + Arg.y*Arg.y );
		},
		get x(){
			return Arg.x;
		},
		get y(){
			return Arg.y;
		}
	};
	
	initFunc();
	
	return ret;
}
function initMove(container,filter,toucher){
	function startMove(e){
		var $doc = $(this);
		if( toucher && $(toucher)[0]!==e.target && !$.contains($(toucher)[0],e.target) ){return false;}
		if( $.contains(this,document.activeElement) ) return true;
		window.addEventListener("mousemove",onMove);
		window.addEventListener("mouseup",endMove);
		mouse.setBy( e );
		console.log("what?????");
		function onMove(e){
			e.preventDefault();
			vector.setBy( mouse.diffTo( e ) )
			position.addBy( vector );
			
			$doc.css( position.toTransform() )
			mouse.setBy( e );
		}
		function setStop(){
			$doc.css( position.toStyle({ //Style 初值;
				x:$doc[0].offsetLeft,
				y:$doc[0].offsetTop
			}) );
			position.setBy(0,0);
			$doc.css( position.toTransform() );	
		}
		function endMove(e){
			window.removeEventListener("mousemove",onMove);
			window.removeEventListener("mouseup",endMove);
			var len = vector.length;
			if(len　> 3){
				var df=0.9;
				function slower(){
					if(len < 1 ){
						setStop();
						return ;
					} 
					position.addBy( vector );
					vector.multiplyBy(df,df);
					len *=df;
					$doc.css( position.toTransform() )
					requestAnimationFrame(slower);
				}
				requestAnimationFrame(slower);
			}else{
				setStop();
			}
		}
	}
	var vector = new Point ("Vector");
	var mouse = new  Point("Mouse","page");
	var position = new Point ("position");
	container = $ (container);
	if(filter!==undefined){
		container.on( "mousedown",filter,startMove);
	}else{
		container.on( "mousedown",startMove );
	}
}
function initScroll(){
	function startMove(e){
		var $doc = $(this);
		if( toucher && $(toucher)[0]!==e.target && !$.contains($(toucher)[0],e.target) ){return false;}
		if( $.contains(this,document.activeElement) ) return true;
		window.addEventListener("mousemove",onMove);
		window.addEventListener("mouseup",endMove);
		mouse.setBy( e );
		
		function onMove(e){
			e.preventDefault();
			vector.setBy( mouse.diffTo( e ) )
			position.addBy( vector );
			
			$doc.css( position.toTransform() )
			mouse.setBy( e );
		}
		function setStop(){
			$doc.css( position.toStyle({ //Style 初值;
				x:$doc[0].offsetLeft,
				y:$doc[0].offsetTop
			}) );
			position.setBy(0,0);
			$doc.css( position.toTransform() );	
		}
		function endMove(e){
			window.removeEventListener("mousemove",onMove);
			window.removeEventListener("mouseup",endMove);
			var len = vector.length;
			if(len　> 3){
				var df=0.9;
				function slower(){
					if(len < 1 ){
						setStop();
						return ;
					} 
					position.addBy( vector );
					vector.multiplyBy(df,df);
					len *=df;
					$doc.css( position.toTransform() )
					requestAnimationFrame(slower);
				}
				requestAnimationFrame(slower);
			}else{
				setStop();
			}
		}
	}
	var vector = new Point ("Vector");
	var mouse = new  Point("WheelEvent","delta");
	var position = new Point ("position");
	container = $ (container);
	if(filter!==undefined){
		container.on( "mousedown",filter,startMove);
	}else{
		container.on( "mousedown",startMove );
	}
}
function initShower(background,container,...arg){
	var docs = [];
	var Time = {currunt:0,end:0,start:0};
	for (var i = 0 ; i< arguments.length;i++){
		docs = docs.concat($(arguments[i]).get());
	}
	function setOpacity(){
		if(Time.all <= 0) {return false;}
		var opacity = (Time.currunt - Time.start)/Time.all;
		if(opacity > 1){
			opacity =1;
		};
		docs.forEach(function (a,b,c,d){
			a.style.opacity = opacity;
		})
		if(opacity >= 1 ){
			return false;
		}
		return true;
	}
	function initNosee(){
		docs.forEach(function (a,b,c,d){
			a.style.opacity = 0;
			a.style.display = "block";
		})
	}
	function draw(){
		Time.currunt = new Date().valueOf();
		return  setOpacity();
	}
	function show(time,callback){
		Time.start = new Date().valueOf();
		Time.all = time;
		Time.end  = Time.start + Time.time;
		initNosee();
		setAnimation (draw,callback);
	}
	function setAnimation(func,callback){
		requestAnimationFrame(function running(){
			if(func()) requestAnimationFrame(running);
			else{
				if(callback)callback();
			} 
		});
	}
	function close(){
		docs.forEach(function (a,b,c,d){
			a.style.opacity = 0;
			a.style.display = "none";
		})
	}
	function select(onestr){
		$(container)
		.find('#'+onestr)[0]
		.select();
	}
	return {
		close,
		show,
		select
	}
}
var Tool={
	SuperExtend(obj1,obj2,optionstr=""){ //Help Fuzhi in Vue
		if(optionstr){
			for (var x in obj1){
				obj1[x][option]  = obj2[x][optionstr];
			}
		}else{
			for (var x in obj1){
				obj1[x]  = obj2[x];
			}
		}
	},
	whatchange(obj,optionstr){
		Object.defineProperty(obj,optionstr,{
			set(v){
				console.log(v,this);
				this.$$option = v;
			},
			get(){
				return this.$$option;
			}
		});
	},
	TempStore:{}
	
}