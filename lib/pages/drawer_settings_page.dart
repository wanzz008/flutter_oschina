import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置' , style: TextStyle( color: Color(AppColors.APP_BAR) ),),
      ),
    );
  }
}
