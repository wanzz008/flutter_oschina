import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabbedPage(),
    );
  }
}

class TabbedPage extends StatefulWidget {
  @override
  _TabbedPageState createState() => _TabbedPageState();
}

class _TabbedPageState extends State<TabbedPage>
    with SingleTickerProviderStateMixin {
  final List<Widget> tabs = <Widget>[
    Icon(Icons.home),
    Icon(Icons.apps),
    Icon(Icons.build),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

//  @override
//  Widget build(BuildContext context) {
//    return DefaultTabController(
//      length: tabs.length,
//      child: Scaffold(
//        appBar: AppBar(
//          title: Text("TabBar"),
//          leading: Icon(Icons.menu),
//          bottom: TabBar(
////          controller: _tabController,
//            tabs: tabs,
//          ),
//        ),
//        body: TabBarView(
////        controller: _tabController,
//          children: tabs.map((Widget tab) {
//            return Center(child: tab);
//          }).toList(),
//        ),
//        bottomNavigationBar: Material(
//          color: Colors.deepOrange,
//          child: TabBar(
////          controller: _tabController,
//            tabs: tabs,
//          ),
//        ),
//      ),
//    );
//  }

  int _index = 0 ;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        title: Text("TabBar"),
        leading: Icon(Icons.menu),

        bottom: TabBar(
          controller: _tabController,
          tabs: tabs,
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: tabs.map((Widget tab) {
          return Center(child: tab);
        }).toList(),
      ),

      bottomNavigationBar: Material(

        color: Colors.deepOrange,
        child: TabBar(
          controller: _tabController,
          tabs: tabs,
        ),
      ),
//    bottomNavigationBar: TabBar(
//        tabs: tabs,
//      controller: _tabController,
//    ),

//    bottomNavigationBar: BottomNavigationBar(
//        currentIndex: _index,
//        onTap: (index){
//          setState(() {
//            _index = index ;
//          });
//        },
//        items: [
//      BottomNavigationBarItem(icon: Icon(Icons.ac_unit),title: Text('haa'),activeIcon: Icon(Icons.near_me)),
//      BottomNavigationBarItem(icon: Icon(Icons.print),title: Text('ss')),
//      BottomNavigationBarItem(icon: Icon(Icons.print),title: Text('dd')),
//    ]),

    );
  }

}