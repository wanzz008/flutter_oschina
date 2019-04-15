import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:flutter_oschina/pages/drawer_about_page.dart';
import 'package:flutter_oschina/pages/drawer_publish_tweet_page.dart';
import 'package:flutter_oschina/pages/drawer_settings_page.dart';
import 'package:flutter_oschina/pages/drawer_tweet_black_house.dart';
import 'package:flutter_oschina/widgets/homepage.dart';


class MyDrawer extends StatelessWidget {

  final String headImg = 'assets/images/cover_img.jpg';

  final List<String> texts = ['发布动弹', '动弹小黑屋', '关于', '设置'];
  final List<IconData> icons = [Icons.send, Icons.home, Icons.error, Icons.settings];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: ListView.separated( // ListView.builder

          padding: const EdgeInsets.all(0.0), //解决状态栏问题 让Drawer占满屏幕

          itemCount: texts.length + 1 ,  // 多了个头布局的图片

          separatorBuilder: (context, index) {
            if (index == 0) {
              return Divider(
                height: 0.0,
              );
            } else {
              return Divider(
                height: 1.0,
              );
            }
          },

          itemBuilder: (context,index){
            if( index == 0 ){
              return Image.asset(
                headImg,
                fit: BoxFit.cover,
              );
            }

            return ListTile(
              title: Text( texts[ index - 1] ),
              leading: Icon( icons[ index -1 ] ),
              trailing: Icon( Icons.arrow_forward_ios),
              onTap: (){

                _goPage(index - 1 , context);

              },
            );
          }
      ),
    );
  }

  void _goPage(index, context ){

    Navigator.pop(context); //先把drawer收起

    switch( index ){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PublishTweetPage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>TweetBlackHousePage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
        break;
    }
  }

}