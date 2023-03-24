import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/common/colors.dart';
import 'package:yoga_student_app/pages/mine_modules/mine_controller.dart';
import 'package:yoga_student_app/pages/mine_modules/personal_wallet_page.dart';
import 'package:yoga_student_app/pages/mine_modules/setting_page.dart';
import 'package:yoga_student_app/pages/mine_modules/shared_wallet_module/shared_wallet_page.dart';
import 'package:yoga_student_app/services/address.dart';

import '../payment_method_modules/payment_method_page.dart';
import 'appointment_record_page.dart';
import 'change_avatar_page.dart';
import 'change_password_page.dart';

class MineView extends GetView{


  MineView({super.key});

  @override
  final MineController controller = Get.put(MineController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: GetBuilder<MineController>(builder: (_){
        return ListView(
          padding: const EdgeInsets.all(0),
          children: [
            SizedBox(
              width: Get.width,
              height: 450,
              child: Stack(
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Image.asset('images/ic_mine_bg.png',fit: BoxFit.fill,),
                  ),
                  Align(alignment: const Alignment(0, -0.5),child:  Container(
                    width: 160,
                   height: 160,
                   clipBehavior: Clip.hardEdge,
                   decoration: const BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(80))
                   ),
                   child: CachedNetworkImage(
                     imageUrl: "${Address.homeHost}/storage/${controller.userModel?.data?.avatar}",
                     placeholder: (context, url) => CircularProgressIndicator(),
                     errorWidget: (context, url, error) => Icon(Icons.error),
                     fit: BoxFit.cover,
                   ),
                 ),),

                  Align(
                    child: Container(
                      margin: const EdgeInsets.only(top: 40,right: 15,left: 15),
                      child: Text('${controller.userModel?.data?.name}',style: TextStyle(fontSize: 25,
                          fontWeight: FontWeight.w700,color: AppColor.themeTextColor),
                        textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),
                    ),
                  ),

                  Align(
                    child: Container(
                      margin: const EdgeInsets.only(top: 40+60),
                      child: Text('${controller.userModel?.data?.phone  }',style: TextStyle(fontSize: 25,
                          fontWeight: FontWeight.w700,color: AppColor.themeTextColor),),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(left: 15,right: 15,top: 50),
                      height: 150,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,  //底色,阴影颜色
                            offset: Offset(1, 2), //阴影位置,从什么位置开始
                            blurRadius: 1,  // 阴影模糊层度
                            spreadRadius: 0,  //阴影模糊大小
                          )],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(flex: 1,child:  GestureDetector(
                            onTap: (){
                              Get.to(const AppointmentRecordPage());
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/ic_shijian.png',width: 50,height: 50,),
                                Text('預約記錄',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: AppColor.themeTextColor),),
                              ],
                            ),
                          ),),

                          Container(
                            height: 80,
                            width: 0.5,
                            color: AppColor.themeTextColor
                          ),

                          Expanded(flex: 1,child:  GestureDetector(
                            onTap: (){
                              Get.to(const PersonalWalletPage());
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/ic_qianbao.png',width: 50,height: 50,),
                                Text('我的錢包',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: AppColor.themeTextColor),),
                              ],
                            ),
                          ),),
                          Container(
                              height: 80,
                              width: 0.5,
                              color: AppColor.themeTextColor
                          ),

                          Expanded(flex: 1,child:  GestureDetector(
                            onTap: (){
                              Get.to(const SharedWalletPage());
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/ic_gx.png',width: 50,height: 50,),
                                Text('共享钱包',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: AppColor.themeTextColor),),
                              ],
                            ),
                          ),),
                        ],
                      ),
                    ),
                  )

                ],
              ),

            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: (){
              Get.to(ChangeAvatarPage('${Address.homeHost}/storage/${controller.userModel?.data?.avatar}'));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black,
                          width: 0.3
                      )
                  ),
                  padding: const EdgeInsets.only(left: 55,right: 55),
                  height: 75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('更換頭像',style: TextStyle(fontWeight: FontWeight.w700,
                          fontSize: 23,color: AppColor.themeTextColor),),
                      const Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                    ],
                  )
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.to(const ChangePasswordPage());
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      width: 0.3
                  ),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(left: 55,right: 55),
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('密碼修改',style: TextStyle(fontWeight: FontWeight.w700,
                        fontSize: 23,color: AppColor.themeTextColor),),
                    const Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                )
              ),
            ),
            GestureDetector(
              onTap: ()async{
               var result = await Get.to(const SettingPage());
               if(result == 'refresh'){
                 controller.requestDataWithUserinfo();
               }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 0.3
                  )
                ),
                padding: const EdgeInsets.only(left: 55,right: 55),
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('設定',style: TextStyle(fontWeight: FontWeight.w700,
                        fontSize: 23,color: AppColor.themeTextColor),),
                    const Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                )
              ),
            ),
            GestureDetector(
              onTap: (){
                // Get.to(const SettingPage());
                controller.requestDataWithLoginOut();
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black,
                          width: 0.3
                      )
                  ),
                  padding: const EdgeInsets.only(left: 55,right: 55),
                  height: 75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('退出登录',style: TextStyle(fontWeight: FontWeight.w700,
                          fontSize: 23,color: AppColor.themeTextColor),),
                      const Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                    ],
                  )
              ),
            ),

          ],
        );
      }),
    );
  }
  _mySliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
          (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            Get.to(const PayMethodPage());
          },
          child: Container(
              margin: const EdgeInsets.only(left: 30,right: 30,top: 11),
              color: Colors.white,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('成人減壓班1201',style: TextStyle(color: AppColor.themeTextColor,fontSize: 18),),
                  Row(
                    children: [
                      Image.asset('images/ic_mine_jinbi.png',width: 35,height: 35,),
                      const SizedBox(width: 5,),
                      Text('25000',style: TextStyle(color: AppColor.themeTextColor,fontSize: 18),),
                    ],
                  )
                ],
              )

          ),
        );
      },
      childCount: controller.dataArr.length,
    );
  }


}