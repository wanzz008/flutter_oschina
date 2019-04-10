import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:flutter_oschina/widgets/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //去掉右上角debug标签
      title: 'OsChina',
      theme: ThemeData(
//        primarySwatch: Colors.blue,
        primaryColor: Color( AppColors.APP_THEME ),
      ),
      home: HomePage(title1: 'OsChina'),
    );
  }
}