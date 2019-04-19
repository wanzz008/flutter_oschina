import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_oschina/pages/shake_page.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {

  List<Map<String, IconData>> blocks = [
    {
      '开源众包': Icons.pageview,
      '开源软件': Icons.speaker_notes_off,
      '码云推荐': Icons.screen_share,
      '代码片段': Icons.assignment,
    },
    {
      '扫一扫': Icons.camera_alt,
      '摇一摇': Icons.camera,
    },
    {
      '码云封面人物': Icons.person,
      '线下活动': Icons.android,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemCount: blocks.length,
      itemBuilder: (context,index1){
        return Container(

          margin: EdgeInsets.all(10.0,),
//          margin: const EdgeInsets.symmetric(vertical: 10.0),

          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1.0,
                color: Color(0xffaaaaaa),
              ),
              bottom: BorderSide(
                width: 1.0,
                color: Color(0xffaaaaaa),
              ),
            ),
          ),

          child: ListView.separated(

            physics: NeverScrollableScrollPhysics(), // 设置禁止滚动的功能 [ 禁止子listview滚动 让父listview滚动 ]
            //内容适配 shrinkWrap多用于嵌套listView中 内容大小不确定
            shrinkWrap: true, // shrinkWrap使用内容适配不会有这样的影响

            itemBuilder:  (context,index2){
              return InkWell(  // InkWell要加上onTap()属性，不然没有水波纹效果
                // 跳转各自界面
                onTap: (){
                  _goToPage( blocks[index1].keys.elementAt(index2));
                },
                child: Container(
                  height: 50,
                  child: ListTile(
                    title: Text( blocks[index1].keys.elementAt(index2) ), // 标题
                    leading: Icon(blocks[index1].values.elementAt(index2)),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              );
            },
                separatorBuilder:  (context,index2){
                  return Divider();
                },

                itemCount: blocks[index1].length ,
          ),
        );
      },

    );
  }

  Future< String > scan() async{
    return  await BarcodeScanner.scan();
  }
  void _goToPage(String title) {
    switch(title){
      case '扫一扫':
        print('扫一扫');
        scan().then((data){
          print( 'scanData.....$data' );
        });

        break;
      case '摇一摇':
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ShakePage() ));

        break;
    }
  }

}
