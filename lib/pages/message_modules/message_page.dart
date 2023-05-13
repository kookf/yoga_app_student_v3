import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/common/colors.dart';
import 'package:yoga_student_app/lang/message.dart';
import 'package:yoga_student_app/pages/message_modules/message_controller.dart';
import 'package:yoga_student_app/pages/message_modules/message_model.dart';
import 'package:yoga_student_app/utils/hex_color.dart';

import '../../components/custom_footer.dart';

class MessagePage extends GetView{

   MessagePage({super.key});

  @override
  final MessagePageController controller = Get.put(MessagePageController());


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColor.themeColor,
      //   title: Text('系統訊息',style: TextStyle(color: AppColor.themeTextColor),),
      // ),
      body: GetBuilder<MessagePageController>(builder: (_){
        return Column(
          children: [
            Container(
                height: MediaQuery.of(context).padding.top+kToolbarHeight,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColor.themeColor,
                ),
                // decoration: const BoxDecoration(
                //   image:DecorationImage(image: AssetImage('images/appbar_bg.png',),
                //     fit: BoxFit.fill,
                //   ),
                // ),
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(top: 25),
                  child: const Text(I18nContent.appTitle,
                    style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                )
            ),
            Expanded(child:Container(
              margin: EdgeInsets.only(top: 10),
              color: HexColor('#E4CCE1'),
              child: EasyRefresh.custom(
                  emptyWidget:controller.dataArr.isEmpty?const Center(child:Text('暫無信息')):null,
                  header: MaterialHeader(),
                  footer: MaterialFooter1(),
                  onRefresh: ()=>controller.onRefresh(),
                  onLoad: ()=>controller.onLoad(),
                  controller: controller.easyRefreshController,
                  slivers: [

                    SliverList(delegate: _mySliverChildBuilderDelegate())
                  ]),
            ),),
          ],
        );
      })
    );
  }
  SliverChildBuilderDelegate _mySliverChildBuilderDelegate(){
    /**
     *
     * $notice_type  類型 1.注册 11.客户预约 12.客户取消预约 13.管理员取消预约
     * 14.预约成功通知 21 充值 22 钱包即将过期 23 共享钱包即将过期
     * 24 钱包已过期 25 共享钱包已过期
     * */
    return SliverChildBuilderDelegate((context, index) {

      String str = '';

      MessageList model = controller.dataArr[index];

      if(model.noticeType ==1){
        str = '註冊';
      }if(model.noticeType ==11){
        str = '學生預約';
      }if(model.noticeType ==12){
        str = '學生取消預約';
      }if(model.noticeType ==13){
        str = '管理員取消預約';
      }if(model.noticeType ==14){
        str = '預約成功通知';
      }if(model.noticeType ==21){
        str = '充值';
      }if(model.noticeType ==22){
        str = '錢包即將過期';
      }if(model.noticeType ==23){
        str = '共享錢包即將過期';
      }if(model.noticeType ==24){
        str = '錢包已過期';
      }if(model.noticeType ==25){
        str = '共享錢包已過期';
      }

      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        // height: 50,
        margin: const EdgeInsets.only(left: 15,right: 15,top: 15),
        child: ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          iconColor: AppColor.themeColor,
          collapsedIconColor: Colors.grey,
          initiallyExpanded: true,
          title:Text(str,style: TextStyle(color: HexColor('#D15299'),
              fontSize: 19,fontWeight: FontWeight.w700),),
          children: [
            Container(
              width: Get.width,
              // color: Colors.red,
              margin: const EdgeInsets.only(left: 15,top: 5,right: 15),
              child: Text('${model.msg}',style: TextStyle(color: HexColor('#D15299'),
                  fontSize: 19,fontWeight: FontWeight.w700),),
            ),
            const SizedBox(height: 15,),
            model.coursesName==null?const SizedBox():Container(
              width: Get.width,
              margin: const EdgeInsets.only(left: 15,top: 0),
              child: Text('課程:${model.coursesName}',style: TextStyle(color: AppColor.themeTextColor,
                  fontSize: 16,fontWeight: FontWeight.w700),),
            ),
            model.coursesName==null?const SizedBox():Container(
              width: Get.width,
              margin: const EdgeInsets.only(left: 15,top: 5),
              child: Text('日期：${model.startDay}',style: TextStyle(color: AppColor.themeTextColor,
                  fontSize: 16,fontWeight: FontWeight.w700),),
            ),
            model.coursesName==null?const SizedBox():Container(
              width: Get.width,
              margin: const EdgeInsets.only(left: 15,top: 5,bottom: 15),
              child: Text('導師：${model.teacherName}',style: TextStyle(color: AppColor.themeTextColor,
                  fontSize: 16,fontWeight: FontWeight.w700),),
            ),
            const SizedBox(height: 5,),
          ],
        ),
      );
    },childCount: controller.dataArr.length);
  }


}