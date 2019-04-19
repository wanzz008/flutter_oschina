import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:flutter_oschina/http/HttpController.dart';
import 'package:flutter_oschina/models/user_info.dart';
import 'package:flutter_oschina/utils/data_utils.dart';

class MyMessagePage extends StatefulWidget {
  @override
  _MyMessagePageState createState() => _MyMessagePageState();
}

class _MyMessagePageState extends State<MyMessagePage> {
  List<String> _tabTitles = ['@我', '评论', '私信'];

  List messageList;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: _tabTitles.length,

      child: Scaffold(
          appBar: AppBar(
            title: Text(
              '我的消息',
              style: TextStyle(color: Color(AppColors.APP_BAR)),
            ),
            iconTheme: IconThemeData(
              color: Color(AppColors.APP_BAR),
            ),

            bottom: TabBar(
                tabs: _tabTitles.map((title)=>Tab(text: title,)).toList()
            ),
          ),
        body: TabBarView(children: [
          Center(
            child: Text('暂无内容'),
          ),
          Center(
            child: Text('暂无内容'),
          ),

          _buildMessageList(),
        ]),
      ),

    );
  }


  // 请求网络 获消息列表
  void _getMessageList() {

    DataUtils.getAccessToken().then((token){

      Map<String, dynamic> params = Map();
      params['page'] = curPage.toString();
      params['pageSize'] = 10.toString();
      params['access_token'] = token;
      params['dataType'] = 'json';
      print('_getMessageListtoken: $token');
      HttpController.post(AppUrls.MESSAGE_LIST,
              (data){
                print('_getMessageList: $data');

                if (data != null && data.isNotEmpty) {
                  Map<String, dynamic> map = json.decode(data);
                  var _messageList = map['messageList'];
                  setState(() {
                    messageList = _messageList;
                  });
                }

          },
          params: params);
    });

  }


  _buildMessageList() {
    if (messageList == null) {
      // 获取消息列表
      _getMessageList();
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }

    return RefreshIndicator(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    // FadeInImage可以加载图片，并可以设置占位图片
                    FadeInImage.assetNetwork(placeholder: 'assets/images/ic_avatar_default.png',
                        image: messageList[index]['portrait'] ,
                        width: 50,
                        height: 50.0,
                        fit: BoxFit.cover,
                      ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${messageList[index]['sendername']}',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${messageList[index]['pubDate']}',
                                style: TextStyle(
                                    fontSize: 12.0, color: Color(0xffaaaaaa)),
                              ),
                            ],
                          ),
                          Text(
                            '${messageList[index]['content']}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: messageList.length),
        onRefresh: _pullToRefresh);
  }

  int curPage = 1;
  Future<Null> _pullToRefresh() async {
    curPage = 1;
    _getMessageList();
    return null;
  }

}
