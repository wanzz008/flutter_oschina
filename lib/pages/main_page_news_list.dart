import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('资讯' , style: TextStyle( color: Color(AppColors.APP_BAR) ),),
      ),
      body: RaisedButton(
          onPressed: (){
              get();
          },
      child: Text('http请求'),
      ),
    );
  }

  void get() async{
    var httpClient = new HttpClient();
//    var uri = new Uri.http('http://manage.youery.com/WebServices/MobileAttendanceService.ashx?Option=Login&userName=wenke&userPwd=123456','');
    var url = Uri.parse('http://manage.youery.com/WebServices/MobileAttendanceService.ashx?Option=Login&userName=wenke&userPwd=1234567');
    var request = await httpClient.getUrl( url ) ;
    var response = await request.close() ;

    var responseBody = await response.transform(utf8.decoder).join();

    print("wzz1-----:" + responseBody );
    var results = json.decode( responseBody );  // 使用dart:convert库可以简单解码和编码JSON。

    print( "wzz2-----:" + results['Message'] );
  }
}
