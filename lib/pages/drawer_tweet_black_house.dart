import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class TweetBlackHousePage extends StatefulWidget {
  @override
  _TweetBlackHousePageState createState() => _TweetBlackHousePageState();
}

class _TweetBlackHousePageState extends State<TweetBlackHousePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动弹小黑屋' , style: TextStyle( color: Color(AppColors.APP_BAR) ),),
      ),
    );
  }
}
