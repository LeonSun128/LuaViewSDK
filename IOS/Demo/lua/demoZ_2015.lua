imageUrl = "http://ico.ooopic.com/ajax/iconpng/?id=96776.png";



imageRander0 = Image();
imageRander0.frame(0,100,100,100);
imageRander1 = Image();
imageRander1.frame(0,100,90,90);
imageRander0.image(imageUrl,function(){
    imageRander1.render(imageRander0,0);
    imageRander1.alpha(0.98)
});

w,h = System.screenSize();--获取屏幕尺寸


--字符串分割测试
s = "中文2344中文2234中文";
while s.len()>0 do
    i,j = s.find("%d+") ;
	if( i and j ) then
        print(s.sub(1,i-1));
		print(s.sub(i,j));
		s = s.sub(j+1,s.len());
	else
		print(s);
		s = "";
    end
end


demoLabel = Label();
demoLabel.frame(0,20,w,40);
demoLabel.text("点击屏幕一次执行一个测试demo");

label = Label();-- 创建一个文本框
label.frame(160,h-80,w,80);


att1 = AttributedString( "12te",  { fontSize=12, fontWeight="bold", foregroundColor=0xff, foregroundColorAlpha=0.9 , charpace=4} );
att2 = AttributedString( "测试",  { fontSize=30, foregroundColor=0xff0000, backgroundColor=0xff, charpace=10} );
att3 = AttributedString( "289",  { fontSize=13, foregroundColor=0x777777, strikethroughStyle=1} );
att4 = AttributedString( "下划", { fontSize=9, foregroundColor=0x777777, underlineStyle=1} );

label2 = Label();
label2.frame(20,30,w-40, 60);
label2.text(att1 + att2 + att3 + att4);

label2.backgroundColor(0xff00FF)
label2.masksToBounds(false);
label2.cornerRadius(4);

label2.shadowOffset(1,1);
label2.shadowRadius(2);
label2.shadowOpacity(8);
label2.shadowColor(0xff0000);

detailInfo = Label();
detailInfo.frame(0, h-40, w, 40);

function detail( info )
    detailInfo.text(info);
    detailInfo.sizeToFit();
end
--------------------------
demoArray = {
function(){
	Http:get("http://www.baidu.com", --http url
		function(request){-- http call back
			print(request );
			print(request.responseStatusCode() );--http请求是否成功 返回码

			local heads =  request.responseHeaderFields();
			for key,value in pairs(heads) do
				print(key .. " : " .. value)
			end
		}
	);	
},

function(){
	Http:post(
	"https://login-test.alibaba-inc.com/authorize/login.do",--url
	nil,--http头信息
	{--http post数据
		appcode="123456",
		name="taobao-hz\xicheng.dxc",
		password="dxc123",
		authtype="system"
	},
		function(request){--http 返回的数据
		  print(request.data() );
		}
	);	
},
function(){
	imageView = Image();
	imageView.image(imageUrl);
	imageView.frame(200,0,64,64);
    detail("Image");
    imageView.center(w/2,h/2);
},
function(){
	--[[
	GestureState.POSSIBLE
    GestureState.BEGAN // 手势开始
    GestureState.CHANGED
    GestureState.END // 手势结束
    GestureState.CANCEL
    GestureState.FAILED
	]]
	local g = PinchGestureRecognizer(function(gesture){
			imageView.transformRoteAndScale( 0, gesture.scale());
		});
	window.addGestureRecognizer(g);
},
function(){
	local g = RotationGesture(function(gesture){
			imageView.transformRoteAndScale( gesture.rotation(), 1);
		});
	window.addGestureRecognizer(g);
},
function(){
	local g = SwipeGesture(function(gesture){
			if( gesture.state()==GestureState.END ) then
				print( "两个手势向左滑动" );
			end
		});
    --[[ GestureDirection.RIGHT = 1,
    GestureDirection.LEFT = 2,
    GestureDirection.UP = 4,
    GestureDirection.DOWN  = 8]]
	g.touchCount(2);
	g.direction( GestureDirection.LEFT);
	window.addGestureRecognizer(g);
},
function(){
	local g = LongPressGesture(function(gesture){
			if( gesture.state()== GestureState.END )  then
				print( "长按手势检测到了" );
			end
		});
	g.touchCount(2);
	window.addGesture(g);
},
function(){
	Vibrate();
},
function(){
	temp = LoadJson("{test=\"haha\"}");
	print(temp.test)	
},
function(){
	print( DB:get("key",-1) );	
},
function(){
	DB:set("key",88);
	print( DB:get("key",-1) );	
},
function(){
	print(System.utdid());
	print(System.version());
	print(System.platform());
	print(System.device());
	print(System.screenSize());
	print(System.gc());
},
function(){
},
function(){
	print(IsMethod(AlertView));
},

function(){
	Alert("title","msg", "ok", "cancel",
	         function(buttonID){--提示框回调
	         	print(buttonID);
	         }
	 )	
},

function(){
	date1 = Date();
	print(date1);
	timeInterval1 = date1.timeInterval();
	print(timeInterval1);
	date2 = Date(timeInterval1-60*60*3);
	date3 = Date("2014-12-02 12:02:40");
	print( date2 );
	print( date3 );
	if date2== date3 then
		print("date2 ==date3");
	else
		print("date2 !=date3");
	end
	print( date1 - date2 );
},


function(){
	transform1 = Transform3D();
	if transform1.isIdentity()  then
		print("transform1.isIdentiy()==true")
	else
		print("transform1.isIdentiy()==false")
	end
	transform1.scale(2,2,2);
	imageView.transform3D(transform1);
	if transform1.isIdentity()  then
		print("transform1.isIdentiy()==true")
	else
		print("transform1.isIdentiy()==false")
	end
	transform1.set(Transform3D());
	if transform1.isIdentity()  then
		print("transform1.isIdentiy()==true")
	else
		print("transform1.isIdentiy()==false")
	end
},
function(){
	transform2 = Transform3D();
	transform2.translation(20,20,20);
	imageView.transform3D(transform2);
},
function(){
	transform3 = Transform3D();
	transform3.translation(20,20,20);
	transform3.rotate(3.14/3,0,1,0)    
	imageView.transform3D(transform3);
},
function(){
	transform4 = transform1.concat(transform2).concat(transform3);
	imageView.transform3D(transform4);
	if transform1==transform2  then
		print("transform1==transform2")
	else
		print("transform1!=transform2")
	end
	transform1.set(Transform3D());
	if transform1==Transform3D()  then
		print("transform1==transform2")
	else
		print("transform1!=transform2")
	end
},
function(){
	imageView.transform3D(Transform3D());
},

function(){
	transform4 = transform1.reset().scale(2,2,2) * transform2 * transform3;
	
		print("动画开始");
	Animate(3,0,
		function(){
			imageView.transform3D(transform4);
		}, 
		function(){
			print("动画结束了");
		}
		);	
},
function(){
	transform4 = transform1.reset().scale(2,2,2) * transform2 * transform3;
	imageView.transform3D(transform4);
	if transform1==transform2  then
		print("transform1==transform2")
	else
		print("transform1!=transform2")
	end
	transform1.set(Transform3D());
	if transform1==Transform3D()  then
		print("transform1==transform2")
	else
		print("transform1!=transform2")
	end
},
function(){
	imageView.removeFromSuper();
	imageView = nil;
	System.gc();	
},

function(){
	timer = Timer(function(){
		print("test timer");
		});
	timer.start(0.1,false);
},
function(){
	timer.start(0.1,true);
},
function(){
	timer.stop();
},

function(){
	scrollView = ScrollView();
	scrollView.backgroundColor(0xff00);
	scrollView.frame(10,10,100,100);
	scrollView.contentSize(600,300);
	print(scrollView.contentSize());
},
function(){
	scrollView.contentOffset(150,0,false);
	print( scrollView.contentOffset() );
},
function(){
--	scrollView.pageEnable(true);
--	print(scrollView.pageEnable());
},
function(){
	window.backgroundColor(0,0.5);
 	pageControl = PagerIndicator();
 	pageControl.center(150,10);
 	pageControl.pageCount(10);
 	print(pageControl.numberOfPages() );
 	scrollView.delegate = function(){
 		local  x,y = scrollView.contentOffset();
 		pageControl.currentPage(x/100);
 		print(pageControl.currentPage());
 	};
},
function(){
	scrollView.removeFromSuper();
	scrollView = nil;
},

function(){
	textFiled = TextField();
	textFiled.placeholder("我是输入框");
	textFiled.backgroundColor(0xffff00);
	textFiled.frame(10,20,300,40);
	textFiled.delegate =  {
		                          开始编辑=function(){
							            print("开始编辑")
							      },
		                          结束编辑=function(){
							            print("结束编辑")
							      },
		                          清理=function(){
							            print("清理")
							      },
						  };
	print(textFiled.placeholder());
},

function(){
	textFiled.resignFirstResponder();
	textFiled.delegate =  function(){
					            print("开始编辑")
					      };
},
function(){
	textFiled.text("GameOver");
	print(textFiled.text());
},
function(){
	textFiled.removeFromSuper();
	textFiled = nil;
},

function(){
	view = Button();
	view.frame(10,60,100,200);
	print( view.frame() );
	view.backgroundColor(0xff0000);
	print(view);
	view.delegate = function(){
		print("button call back");
	}

	title = Label();
	title.text("测试测试测试测试测试测试测试测试测试");
	title.backgroundColor(0xff00ff);
	title.frame(50,50,500,30);
	title.sizeToFit();
	view.addSubView(title);
},


function(){
	urlA = "http://img2.3lian.com/img2007/13/68/20080405154401434.png";
	urlB = "http://img2.3lian.com/img2007/13/68/20080405154401440.png";
	urlC = "http://img2.3lian.com/img2007/13/68/20080405154401926.png";

	button = Button();
	button.frame(150,50,100,100);
	button.image(urlA ,urlB,urlC )
	button.delegate = function(){
		print("button call back");
	};
	button.enabled(false);
},

function(){
	textButton = Button();
	textButton.frame(150,10,100,40);
	textButton.title("A","B","C","D");
	textButton.delegate = function(){
		print("textButton call back");
	};
},

function(){
	view.hidden(true);
	print( view.hidden() );
},
function(){
	view.hidden(false);
	print( view.hidden() );
},
function(){
	view.userInteractionEnabled = false;
	print( view.userInteractionEnabled() );
},
function(){
	view.userInteractionEnabled = true;
	print( view.userInteractionEnabled() );
},
function(){
	print( view.backgroundColor() );
	view.backgroundColor(0xff);
	print( view.backgroundColor() );
},
function(){
	print( view.alpha() );
	view.alpha(0.5);
	print( view.alpha() );
},
function(){
	view.cornerRadius(8);
	print( view.cornerRadius() );
},
function(){
	view.borderWidth(2);
	print( view.borderWidth() );
},
function(){
	view.borderColor(0xff0000);
	print( view.borderColor() );
},
function(){
	view.clipsToBounds(true);
	print( view.clipsToBounds() );
},
function(){
	view.clipsToBounds(false);
	print( view.clipsToBounds() );
},
function(){
	print( view.center() );
	view.center(160,240);
	print( view.center() );
},
function(){
	title.removeFromSuper();
},
function(){
	view.addSubView(title);
},
function(){
	title.transformRoteAndScale( 3.14/2,  2);
},
function(){
	title.transformRoteAndScale( 0, 1);
},
function(){
	title.anchorPoint( 0.0, 0.5 );
},
function(){
	title.transformRoteAndScale( 3.14/2,  2);
},

function(){
	dragGesture = PanGestureRecognizer(
		function( g ){
			print("drag");
		}
	);

	window.addGestureRecognizer(dragGesture);
},

function(){
	window.removeGestureRecognizer(dragGesture);
},

function(){
	print("------end------");
	window.release();
},
}
index = 1;


function setLabel( i )
		label.text(""..i);
		if ( i%2==1 ) then
			label.color(0xff,1);
		else 
			label.color(0,0.2);
		end
		label.font(64);
		label.sizeToFit();
		label.center(w/2,h-60);
end

setLabel(1);

gesture = TapGesture(
	function( g ){
		print("Test"..index .. " : ");
		func = demoArray[index];
		func();
		index = index + 1;
		setLabel(index);
	}
);

window.addGestureRecognizer(gesture);

window.frame(0,0,w,h);


window.delegate = {
viewWillAppear = function(){
	print("viewWillAppear");
},
viewDidAppear = function(){
	print("viewDidAppear");
},
viewWillDisAppear = function(){
	print("viewWillDisAppear");
},
viewDidDisAppear = function(){
	print("viewDidDisAppear");
},
keyboardWillShow = function(){
	print("keyboardWillShow");
},
keyboardDidShow = function(){
	print("keyboardDidShow");
},
keyboardWillHide = function(){
	print("keyboardWillHide");
},
keyboardDidHide = function(){
	print("keyboardDidHide");
},
layoutSubviews = function(){
	print("layoutSubviews");
},

};


