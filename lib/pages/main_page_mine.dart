import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_oschina/common/event_bus.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:flutter_oschina/http/HttpController.dart';
import 'package:flutter_oschina/pages/login_page.dart';
import 'package:flutter_oschina/pages/my_message_page.dart';
import 'package:flutter_oschina/pages/uesr_detail_page.dart';
import 'package:flutter_oschina/utils/data_utils.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  List mTitles = [
    '我的消息',
    '阅读记录',
    '我的博客',
    '我的问答',
    '我的活动',
    '我的团队',
    '邀请好友',
  ];
  List mIcons = [
    Icons.message,
    Icons.receipt,
    Icons.time_to_leave,
    Icons.message,
    Icons.receipt,
    Icons.time_to_leave,
    Icons.receipt
  ];

  String avatarUrl ; // 头像地址
  String userName ; // 用户名称

  @override
  void initState() {
    super.initState();

    //尝试显示用户信息
    _showUerInfo();

    //  登录成功后，调用eventBus.fire(LoginEvent()) 后会走下面的回调
    eventBus.on<LoginEvent>().listen((event) {

      print('eventBus------: LoginEvent.....');
      _getUerInfo();
    });

    // 设置里面，点击退出登录，会走这里
    eventBus.on<LogoutEvent>().listen((event) {
      print('eventBus------: LogoutEvent.....');
      _showUerInfo();
    });

  }

  _showUerInfo() {
    DataUtils.getUserInfo().then((user){

      if(mounted){
        setState(() {
          if( user != null ){
            print('getUserInfo------: user != null.....');
            avatarUrl = user.avatar ; // 头像地址
            userName = user.name ; // 名称
          }else{
            print('getUserInfo------: user = null.....');
            avatarUrl = null ; // 头像地址
            userName = null ; // 名称
          }

        });
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _getHeader();
          }
          index -= 1;
          return ListTile(
            title: Text(mTitles[index]),
            leading: Icon(mIcons[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              DataUtils.isLogin().then((isLogin){
                  if( isLogin ){
                    _goToPage(index);
                  }else{
                    _goLogin();
                  }
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1.0,
          );
        },
        itemCount: mTitles.length + 1);
  }

  /**
   * 获取头布局
   */
  Container _getHeader() {
    return Container(
      alignment: Alignment.center, // 居中
      color: Color(AppColors.APP_THEME),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 居中
        children: <Widget>[
//          CircleAvatar(
//            backgroundImage:NetworkImage( 'https://oscimg.oschina.net/oscnet/up-37af489df9a42b0571012b0dcfd489fe.jpg!/both/200x200'),
//
//            radius: 50.0,
//          ),

//          Image.network( avatarUrl ??= 'https://oscimg.oschina.net/oscnet/up-37af489df9a42b0571012b0dcfd489fe.jpg!/both/200x200',
//
//            width: 100, height: 100,) ,

          // GestureDetector并不具有显示效果，而是检测由用户做出的手势(点击拖动和缩放)
          GestureDetector(
            child: Container(
              width: 60.0,
              height: 60.0,
              // 背景装饰
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xffffffff),
                  width: 2.0,
                ),
                image: DecorationImage(
                  image: avatarUrl == null ? AssetImage('assets/images/ic_avatar_default.png'):NetworkImage(avatarUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 有的时候我们需要像Android那样使用一个占位图或者图片加载出错时显示某张特定的图片，这时候需要用到 FadeInImage 这个组件：
//            child: avatarUrl == null ?
//                  Image.asset('assets/images/ic_avatar_default.png',width: 60, height: 60,):
//                  FadeInImage.assetNetwork(placeholder: 'assets/images/ic_avatar_default.png',
//                    image: avatarUrl ,
//                    width: 60,
//                    height: 60.0,
//                    fit: BoxFit.cover,
//                  ),

            onTap: () {
              print('点击了头像');
              DataUtils.isLogin().then((isLogin){
                if(isLogin){
                  // 进入详情
                  _goUserDetail();
                }else{
                  // 登录
                  _goLogin();
                }
              });
            },
            onDoubleTap: () {
              print('双击了头像');
            },
          ),

          SizedBox(
            height: 10.0,
          ),
          Text(
            userName ??= '点击登录头像',
            style: TextStyle(color: Color(AppColors.APP_BAR)),
          ),
        ],
      ),
    );
  }

  /**
   * 点击头像进行登录
   * 此处会通过LoginPage里的Navigator.pop(context, 'refresh');返回一个值
   */
  void _goLogin() async{

      final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage()));

      // 接到登录的webview返回的消息 开始刷新界面
      if( result != null && result == 'refresh'){
        print('_goLogin------: refresh.....');
        eventBus.fire(LoginEvent()) ; // 之后会走eventBus的回调
      }
  }

  _goUserDetail() async{
    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UserDetailPage()));
  }

  _goMyMessagePage() async{
    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyMessagePage()));
  }

  void _goToPage(int index) {
    switch (index){
      case 0:
        _goMyMessagePage();
        break;
      case 1:
        break;
      case 2:
        break;

      case 3:
        break;
    }


  }

  void _getUerInfo() {
    //获取用户信息并显示
    DataUtils.getAccessToken().then((token){
      // 获取个人信息 头像、名称、id数据
      Map<String, String> params = Map();
      params['access_token'] = token;
      params['dataType'] = 'json';
      HttpController.post(AppUrls.USER,
            (data){
          // {"gender":"male","name":"空白格tel","location":"北京 海淀","id":2910508,"avatar":"https://oscimg.oschina.net/oscnet/up-842fd310b20da0da75e6428f62380042.jpg!/both/50x50",

          print('User data------: $data');
          var map = json.decode( data );
          print('User avatar------: ${map['avatar']}');
          setState(() {
            avatarUrl = map['avatar']; // 头像地址
            userName = map['name']; // 名称
          });

          DataUtils.saveUserInfo(map);

        },
        params: params,
      );

    });
  }
}
