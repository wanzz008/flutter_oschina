import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_oschina/common/event_bus.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:flutter_oschina/http/HttpController.dart';
import 'package:flutter_oschina/pages/login_page.dart';
import 'package:flutter_oschina/utils/data_utils.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  List _news = List();
  bool _isLogin = false ; // 是否登录

  StreamSubscription subscription ;

  @override
  void dispose() {
    super.dispose();
    subscription.pause() ;
  }

  @override
  void initState() {
    super.initState();

    DataUtils.isLogin().then((isLogin){
      if ( isLogin ){

        _getNewsList(); // 如果登录了，去请求数据

        setState(() {
          if ( !mounted ) return ;
          _isLogin = true ;
        });

      }
    });

    //  登录成功后，调用eventBus.fire(LoginEvent()) 后会走下面的回调
    subscription = eventBus.on<LoginEvent>().listen((event) {

      print('eventBus------[page_news]: LoginEvent.....');

      _isLogin = true ;
      _getNewsList(); // 如果登录了，去请求数据

    });
    subscription.resume() ;

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: _isLogin
          ? RefreshIndicator(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _news[index]['title'],
                      maxLines: 2,
                      style: TextStyle(fontSize: 18.0,fontWeight:  FontWeight.w700 , ), // FontWeight.w700字体加重
                    ),
                    Row(
                      children: <Widget>[
                        Text('@${_news[index]['author']}' ,style: TextStyle(color: Color(0xff000000)),),
                        Text(_news[index]['pubDate']),
                        Expanded(child: SizedBox()),
                        Icon(Icons.message),
                        Text(_news[index]['commentCount'].toString()),
                      ],
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: _news.length ),
          onRefresh: (){
            _pullToRefresh();
          })
          : Center(
              child: RaisedButton(onPressed: () {
                _goLogin();
              }, child: Text('请先登录')),
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

  int curPage = 1;
  Future<Null> _pullToRefresh() async {
    curPage = 1;
    _getNewsList();
    return null;
  }

  // 请求新闻列表数据
  void _getNewsList() async{
    await DataUtils.getAccessToken().then((token) {
      print('token....$token');
      Map<String, dynamic> params = Map();
      params['catalog'] = 1.toString(); // 1-所有|2-综合新闻|3-软件更新
      params['page'] = curPage.toString(); // 页数
      params['pageSize'] = 10.toString(); //每页条数
      params['access_token'] = token;
      params['dataType'] = 'json'; // 返回数据类型

      HttpController.post(AppUrls.NEWS_LIST, (data) {
        print('_getNEWS_LIST: $data');
        Map map = json.decode(data);
        List news = map['newslist'];
        setState(() {
          if (!mounted) return;
          _news = news;
        });
      }, params: params);
    });
  }


}
