import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:flutter_oschina/http/HttpController.dart';
import 'package:flutter_oschina/utils/data_utils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/**
 * WebviewScaffold 在flutter_webview_plugin包下
 * 用来加载webview
 */
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // url变化的监听
  FlutterWebviewPlugin _flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool isLoading = true ;

  @override
  void initState() {
    super.initState();
    //监听url变化
    _flutterWebviewPlugin.onUrlChanged.listen(
//        https://www.oschina.net/action/oauth2/authorize?response_type=code&client_id=PjPvTjHFGdoMphxQ0awm&redirect_uri=https://www.baidu.com

            (url){
                print('LoginWebPage onUrlChanged: $url');

                setState(() {
                  isLoading = false ;
                });

                // https://www.baidu.com/?code=dTF8G4&state=
                if (url != null && url.length > 0 && url.contains('?code=')) {
                  //提取授权码code
                  String code = url.split('?')[1].split('&')[0].split('=')[1];
                  Map<String, String> params = Map();
                  params['client_id'] = AppInfo.CLIENT_ID;
                  params['client_secret'] = AppInfo.CLIENT_SECRET;
                  params['grant_type'] = 'authorization_code';
                  params['redirect_uri'] = AppInfo.REDIRECT_URI;
                  params['code'] = '$code';
                  params['dataType'] = 'json';

                  HttpController.post(AppUrls.TOKEN,
                       (data){
                         print('LoginWebPage token: $data');
                        if( data != null ){
                          Map<String ,dynamic > map = json.decode( data );
                          if( map != null && map.isNotEmpty ){
                            // 把登录获取的token等存储下来
                            DataUtils.saveLoginInfo(map);
                            //弹出当前路由，并返回refresh通知我的界面刷新数据
                            Navigator.pop(context, 'refresh'); // 会自动退出当前界面
                          }
                        }
                       },
                      params: params) ;

                }
        }
    );
  }
  @override
  Widget build(BuildContext context) {

    // AppBar
    List<Widget> _appBarTitle =[
      Text(
        '登录开源中国',style: TextStyle(color: Color(AppColors.APP_BAR)),
      ),
      SizedBox(
        width: 10.0,
      ),
    ];
    if( isLoading ){
      _appBarTitle.add(CupertinoActivityIndicator());
    }
    return WebviewScaffold(

        appBar: AppBar(
          title: Row(
            children: _appBarTitle ,
          ),
        ),
      //https://www.oschina.net/action/oauth2/authorize?response_type=code&client_id=PjPvTjHFGdoMphxQ0awm&redirect_uri=https://www.baidu.com
        url: AppUrls.AUTHORIZE +
            'response_type=code&client_id=' +
            AppInfo.CLIENT_ID +
            '&redirect_uri=' +
            AppInfo.REDIRECT_URI,
        withJavascript: true,
        //允许执行js
        withLocalStorage: true,
        //允许本地存储
        withZoom: true, //允许网页缩放

    );
  }

  @override
  void dispose() {
    super.dispose();
    _flutterWebviewPlugin.close();
  }

}
