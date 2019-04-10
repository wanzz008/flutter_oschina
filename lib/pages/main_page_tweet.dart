import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class TweetPage extends StatefulWidget {
  @override
  _TweetPageState createState() => _TweetPageState();
}

class _TweetPageState extends State<TweetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动弹' , style: TextStyle( color: Color(AppColors.APP_BAR) ),),
      ),
    );
  }
}
