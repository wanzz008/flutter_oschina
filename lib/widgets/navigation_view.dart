import 'package:flutter/material.dart';

/**
 * 生成BottomNavigationBarItem的类
 */
class NavigationView{

  final String title ;
  final String icon;
  final String activeIcon;

  final BottomNavigationBarItem barItem ;

  // assert断言： 如果assert 的判断为true, 则继续执行下面的语句。反之则会丢出一个异 AssertionError 。 也可以输出自己定义的一句话
  NavigationView({ @required this.title, @required this.icon, @required this.activeIcon } )
      : assert( title != null , "title为空了-----------"),
        assert( icon != null ),
        assert( activeIcon != null ),
        barItem = BottomNavigationBarItem(
          // 要控制icon的大小
          icon: Image.asset( icon , width: 20.0, height: 20.0, ),
          title: Text( title  ), // ,style: TextStyle(color: Color(0xff000000)),
          activeIcon: Image.asset(activeIcon , width: 20.0, height: 20.0, ),
      );


}