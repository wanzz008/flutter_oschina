import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'  , style: TextStyle( color: Color(AppColors.APP_BAR) ), ),
      ),
    );
  }
}
