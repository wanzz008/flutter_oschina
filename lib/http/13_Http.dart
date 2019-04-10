import 'dart:convert';
 
import 'package:flutter/material.dart';
import 'package:flutter_oschina/http/HttpController.dart';
import 'package:http/http.dart' as http; //导入网络请求相关的包

 void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'MyFlutter',
        home: HomePage(),
    
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();
  }
}

class HomeState extends State<HomePage> {
 //数据源
  List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pullNet1();

  }
  // http://www.wanandroid.com/project/list/1/json?cid=1
  void _pullNet() async {
    await http.get("http://www.wanandroid.com/project/list/1/json?cid=1")
        .then((http.Response response) {

          var convertDataToJson = json.decode(response.body); // response.body 为String类型
          convertDataToJson = convertDataToJson["data"]["datas"];

          print(convertDataToJson);

          setState(() {
            data = convertDataToJson;
          });

        }
    );
  }

  void _pullNet1()  {
    HttpController.get("http://www.wanandroid.com/project/list/1/json?cid=1",

          (responseBody){  // 此data为res.body 为String类型

            if( responseBody != null ){
              print("data != null---------------");
              print(responseBody);
            }else{
              print("data == null---------------");
            }

            var convertDataToJson = json.decode( responseBody );
            convertDataToJson = convertDataToJson["data"]["datas"];

            print(convertDataToJson);

            setState(() {
              data = convertDataToJson;
            });

          } ,
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: AppBar(title: Text("网络请求"),),
      body:  new ListView(
        // 这里要注意：要先判断data的值
        // 因为网络请求是异步的，当前界面因为要执行build界面的绘制，导致我们在_getItem中map遍历data数据时是个空值，然后再异步请求成功后，setState又重新给data赋了值，然后触发了界面重新绘制，这时候，map遍历是有值，然后就出现了一下会出现异常，然后又好了的原因。
          children:  data != null ? _getItem() : _loading()
      ),
    );
  }

  //预加载布局
  List<Widget> _loading() {
    return <Widget>[
      new Container(
        height: 300.0, 
        child: new Center(
          child:new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(
                  strokeWidth: 1.0,
                ),
                new Text("正在加载"),
              ],
        )
        ),
        )
    ];
  }


   List<Widget> _getItem() {
    return data.map((item) {
      return new Card(child: new Padding(
        padding: const EdgeInsets.all(10.0), child: _getRowWidget(item),),
        elevation: 3.0,
        margin: const EdgeInsets.all(10.0),);
    }).toList();
  }


  Widget _getRowWidget(item) {
    return new Row(children: <Widget>[
      new Flexible(
          flex: 1,
          fit: FlexFit.tight, //和android的weight=1效果一样
          child: new Stack(children: <Widget>[
            new Column(children: <Widget>[
              new Text("${item["title"]}".trim(),
                  style: new TextStyle(color: Colors.black, fontSize: 20.0,),
                  textAlign: TextAlign.left),
              new Text("${item["desc"]}", maxLines: 3,)
            ],)
          ],)
      ),
      new ClipRect(child: new FadeInImage.assetNetwork(
//        placeholder: "images/ic_shop_normal.png",
        placeholder: "assets/images/ic_nav_news_actived.png",
        image: "${item['envelopePic']}",
        width: 50.0,
        height: 50.0,
        fit: BoxFit.fitWidth,),),
    ],);
  }
}