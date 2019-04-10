import 'dart:convert';
 
import 'package:flutter/material.dart';
import 'HttpController.dart';

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
    return new Page();
  }
}
 
class Page extends State<HomePage> {
  String dataStr = "";
  var _items = [];
 
  @override
  Widget build(BuildContext context) {
    return layout(context);
  }
 
  @override
  void initState() {
    super.initState();
    getData();
  }
  
  // 进行网络请求
  void getData() {
    print("---------------");
    Map<String, String> map = new Map();
    map["v"] = "1.0";
    map["month"] = "7";
    map["day"] = "25";
    map["key"] = "bd6e35a2691ae5bb8425c8631e475c2a";

    // http://api.juheapi.com/japi/toh?v=1.0&month=8&day=22&key=bd6e35a2691ae5bb8425c8631e475c2a
    HttpController.post(
      "http://api.juheapi.com/japi/toh", 

      (data) {
        if (data != null) {
          // json.decode(source)
          final body = json.decode(data.toString());
          final feeds = body["result"];
          var items = [];
          
          feeds.forEach((item) {
            items.add(Model(item["_id"], item["title"], item["pic"], item["year"],
                item["month"], item["day"], item["des"], item["lunar"]));
          });
          print("data != null---------------");
          setState(() {
            dataStr = data.toString();
            _items = items;
          });
      }else{
         print("data == null---------------");
      }
    }, 
    params: map,
    errorCallback: (errorMessage){
        print("error---------------");
        print(errorMessage);
    });
  }
 
  Widget layout(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body:
          new ListView.builder(
            itemCount: _items.length, 
            itemBuilder: itemView
            ),
    );
  }
 
  Widget itemView(BuildContext context, int index) {
    Model model = this._items[index];
    //设置分割线
    if (index.isOdd) return new Divider(height: 2.0);
    return new Container(
        color: Color.fromARGB(0x22, 0x49, 0xa9, 0x8d),
        child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Text('${model.year}年${model.month}月${model.day}日',
                            style: new TextStyle(fontSize: 15.0)),
                        new Text('(${model.lunar})',
                            style: new TextStyle(fontSize: 15.0)),
                      ],
                    ),
                    new Center(
                      heightFactor: 6.0,
                      child: new Text("${model.title}",
                          style: new TextStyle(fontSize: 17.0)),
                    )
                  ],
                ))));
  }
 
  Widget buildAppBar(BuildContext context) {
    return new AppBar(title: const Text('历史今日'));
  }
}
 
class Model {
  String _id;
  String title;
  String pic;
  int year;
  int month;
  int day;
  String des;
  String lunar;
 
  Model(this._id, this.title, this.pic, this.year, this.month, this.day,
      this.des, this.lunar);
}