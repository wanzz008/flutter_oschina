# flutter_oschina

用Flutter实现开源中国项目.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

- [开源中国api文档] https://www.oschina.net/openapi/docs/news_list

## Day 1：
- bottomNavigationBar是底部导航栏  BottomNavigationBarItem是子条目
    -- type: BottomNavigationBarType.fixed, // 需要加此配置 不然BottomNavigationBarItem的字体颜色为白色
- PageView用来切换主体界面  PageController为其控制器
- Drawer是滑出来的抽屉效果  //  padding: const EdgeInsets.all(0.0), //解决状态栏问题 让Drawer占满屏幕
- iconTheme: IconThemeData(color: Color(AppColors.APP_BAR) ), // 控制AppBar的返回按钮样式
- CupertinoActivityIndicator() --> 加载的转圈圈效果
- 用GestureDetector包裹其他widget，可以让widget有点击效果： GestureDetector并不具有显示效果，而是检测由用户做出的手势(点击拖动和缩放)

## Day 2：
- http库用来做网络请求
- flutter_webview_plugin库是webview的插件库
- WebviewScaffold： url属性放链接即可加载webview
- FlutterWebviewPlugin可以监听url的变化：_flutterWebviewPlugin.onUrlChanged.listen()
- 获取到数据后对数据进行持久化：shared_preferences库
- final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage())) --> 跳转page
- Navigator.pop(context, 'refresh'); // 跳出当前界面
- 通过获取的result，判断是哪个界面返回的
- eventBus.fire(LoginEvent()) ; // 之后会走eventBus的回调
- eventBus.on<LoginEvent>().listen()  // eventBus的回调

## Day 3：
- FadeInImage.assetNetwork() 可以加载网络图片，并可以设置占位图片
- AppBar下的bottom属性TabBar
- 配合Scaffold下body属性TabBarView，可以有viewpager左右滑动的效果