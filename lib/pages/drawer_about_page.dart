import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'  , style: TextStyle( color: Color(AppColors.APP_BAR) ),),
      ),
    );
  }
}
