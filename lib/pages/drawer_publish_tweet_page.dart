import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class PublishTweetPage extends StatefulWidget {
  @override
  _PublishTweetPageState createState() => _PublishTweetPageState();
}

class _PublishTweetPageState extends State<PublishTweetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发布动弹' , style: TextStyle( color: Color(AppColors.APP_BAR) ),),
      ),
    );
  }
}
