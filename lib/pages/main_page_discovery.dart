import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发现'  , style: TextStyle( color: Color(AppColors.APP_BAR) ),),
      ),
    );
  }
}
