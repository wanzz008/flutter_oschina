import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:flutter_oschina/pages/main_page_discovery.dart';
import 'package:flutter_oschina/pages/main_page_news_list.dart';
import 'package:flutter_oschina/pages/main_page_mine.dart';
import 'package:flutter_oschina/pages/main_page_tweet.dart';
import 'package:flutter_oschina/widgets/mydrawer.dart';
import 'package:flutter_oschina/widgets/navigation_view.dart';

class HomePage extends StatefulWidget {

  final String title1;

  const HomePage({Key key, this.title1}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _appBarTitle = ['资讯','动弹','发现', '我的'] ;
  int _currentIndex = 0 ;
  List<BottomNavigationBarItem> _bottomItems;
  List<Widget> _pages ;

  PageController _pageController ;

  @override
  void initState() {
    super.initState();

    // 底部按钮的集合
    _bottomItems = __bottomItems();
    // 主界面切换Page的集合
    _pages = [
      NewsListPage(),
      TweetPage(),
      DiscoveryPage(),
      MinePage(),
    ] ;

    // PageView的控制器，为了让底部导航栏按钮点了之后会切换PageView
    _pageController = new PageController( initialPage: _currentIndex ,viewportFraction: 1 ); // viewportFraction:占屏幕比例   viewportFraction: 0.5

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          _appBarTitle[ _currentIndex ] ,
          style: TextStyle( color: Color(AppColors.APP_BAR) ),
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APP_BAR) ), // 让AppBar的返回按钮，变成白色
      ),

      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // 需要加此配置 不然BottomNavigationBarItem的字体颜色为白色
          //默认选中首页
          currentIndex: _currentIndex,
          iconSize: 24.0, // 默认就是24.0
          items: _bottomItems ,

          onTap: (index){
              setState(() {
                _currentIndex = index ;
              });
              // 点击底部按钮时，切换pageview，用duration来控制页面切换的速度
              _pageController.animateToPage( index, duration: Duration(microseconds: 1), curve: Curves.ease ) ;
            },

      ),

      // 主体 用PageView进行滑动
      body: PageView.builder(
//          physics: NeverScrollableScrollPhysics(),  // 禁止滑动
          itemCount: _pages.length ,
          itemBuilder: (context, index){
            return _pages[index];
          },
          controller: _pageController ,
          onPageChanged: (index){
            setState(() {
              _currentIndex = index ;
            });
          },
      ),

      // 抽屉
      drawer:MyDrawer(),
    );
  }


  List<BottomNavigationBarItem> __bottomItems() {
    return [
      NavigationView(
        title: '资讯',
        icon: 'assets/images/ic_nav_news_normal.png',
        activeIcon: 'assets/images/ic_nav_news_actived.png',
      ).barItem,
      NavigationView(
        title: '动弹',
        icon: 'assets/images/ic_nav_tweet_normal.png',
        activeIcon: 'assets/images/ic_nav_tweet_actived.png',
      ).barItem,
      NavigationView(
        title: '发现',
        icon: 'assets/images/ic_nav_discover_normal.png',
        activeIcon: 'assets/images/ic_nav_discover_actived.png',
      ).barItem,
      NavigationView(
        title: '我的',
        icon: 'assets/images/ic_nav_my_normal.png',
        activeIcon: 'assets/images/ic_nav_my_pressed.png',
      ).barItem,
    ];
  }

}
