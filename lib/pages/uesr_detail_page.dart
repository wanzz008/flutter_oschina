import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:flutter_oschina/http/HttpController.dart';
import 'package:flutter_oschina/models/user_info.dart';
import 'package:flutter_oschina/utils/data_utils.dart';

class UserDetailPage extends StatefulWidget {
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  void initState() {
    super.initState();
    // 获取详情
    _getUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '用户详情',
          style: TextStyle(color: Color(AppColors.APP_BAR)),
        ),
      ),
      body: buildSingleChildScrollView(),
    );
  }

  String avatarUrl;
  UserInfo _userInfo;

  _getUserDetail() {
    //获取用户详情
    DataUtils.getAccessToken().then((token) {
      print('accessToken: $token');
      // 获取个人信息 头像、名称、id数据
      Map<String, String> params = Map();
      params['access_token'] = token;
      params['dataType'] = 'json';
      HttpController.post(
        AppUrls.MY_INFORMATION,
        (data) {
          print('UserDetail data------: $data');
          // --------------------
          if (data != null && data.isNotEmpty) {
            Map<String, dynamic> map = json.decode(data);
            UserInfo userInfo = UserInfo();
            userInfo.uid = map['uid'];
            userInfo.name = map['name'];
            userInfo.gender = map['gender'];
            userInfo.province = map['province'];
            userInfo.city = map['city'];
            userInfo.platforms = map['platforms'];
            userInfo.expertise = map['expertise'];
            userInfo.joinTime = map['joinTime'];
            userInfo.lastLoginTime = map['lastLoginTime'];
            userInfo.portrait = map['portrait'];
            userInfo.fansCount = map['fansCount'];
            userInfo.favoriteCount = map['favoriteCount'];
            userInfo.followersCount = map['followersCount'];
            userInfo.notice = map['notice'];

            setState(() {
              _userInfo = userInfo;
            });
          }
        },
        params: params,
      );
    });
  }

  Widget buildSingleChildScrollView() {
    // SingleChildScrollView: 一个可以滚动单个widget的框
    // 只容纳一个widget，当空间大小不够的时候，里面的widget可以在主轴上滚动。
    return SingleChildScrollView(
      child: _userInfo == null
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    //TODO
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '头像',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(_userInfo.portrait),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    //TODO
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '昵称',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          _userInfo.name,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, right: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '加入时间',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        _userInfo.joinTime,
                        // _userInfo.joinTime.split(' ')[0],
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    //TODO
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '所在地区',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          _userInfo.city,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    //TODO
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            '开发平台',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            // 'Android,C/C++,J2ME/K-Java,Python,.NET/C#',
                            _userInfo.platforms.toString(),
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    //TODO
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            '专长领域',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            // '手机软件开发，服务器开发，软件开发管理',
                            _userInfo.expertise.toString(),
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, right: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '粉丝数',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        _userInfo.fansCount.toString(),
                        style: TextStyle(fontSize: 20.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, right: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '收藏数',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        _userInfo.favoriteCount.toString(),
                        style: TextStyle(fontSize: 20.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, right: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '关注数',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        _userInfo.followersCount.toString(),
                        style: TextStyle(fontSize: 20.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
    );
  }
}
