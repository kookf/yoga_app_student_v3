
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/common/colors.dart';
import 'package:yoga_student_app/utils/hex_color.dart';

class MessagePage extends GetView{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColor.themeColor,
      //   title: Text('系統訊息',style: TextStyle(color: AppColor.themeTextColor),),
      // ),
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).padding.top+kToolbarHeight,
              width: Get.width,
              decoration: const BoxDecoration(
                image:DecorationImage(image: AssetImage('images/appbar_bg.png',),
                  fit: BoxFit.fill,
                ),
              ),
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.only(top: 25),
                child: const Text('MeMO Yoga',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
              )
          ),
          Expanded(child:  Container(
           color: HexColor('#E4CCE1'),
           child: EasyRefresh.custom(slivers: [
             SliverList(delegate: _mySliverChildBuilderDelegate())
           ]),
         ),),
        ],
      )
    );
  }
  SliverChildBuilderDelegate _mySliverChildBuilderDelegate(){
    return SliverChildBuilderDelegate((context, index) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        // height: 50,
        margin: EdgeInsets.only(left: 15,right: 15,top: 15),
        child: ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          iconColor: AppColor.themeColor,
          collapsedIconColor: Colors.grey,
          initiallyExpanded: true,
          title:Text('報名成功，請準時出席',style: TextStyle(color: HexColor('#D15299'),
              fontSize: 19,fontWeight: FontWeight.w700),),
          children: [
            // Container(
            //   margin: EdgeInsets.only(left: 15,top: 5),
            //   child: Text('報名成功，請準時出席',style: TextStyle(color: HexColor('#D15299'),
            //       fontSize: 19,fontWeight: FontWeight.w700),),
            // ),
            Container(
              margin: EdgeInsets.only(left: 15,top: 0),
              child: Text('成人減壓班1222',style: TextStyle(color: AppColor.themeTextColor,
                  fontSize: 16,fontWeight: FontWeight.w700),),
            ),
            Container(
              margin: EdgeInsets.only(left: 15,top: 5),
              child: Text('日期：2023年02月12日 （星期四）',style: TextStyle(color: AppColor.themeTextColor,
                  fontSize: 16,fontWeight: FontWeight.w700),),
            ),
            Container(
              margin: EdgeInsets.only(left: 15,top: 5,bottom: 15),
              child: Text('導師：Perise',style: TextStyle(color: AppColor.themeTextColor,
                  fontSize: 16,fontWeight: FontWeight.w700),),
            ),
          ],
        ),
      );
    },childCount: 10);
  }


}