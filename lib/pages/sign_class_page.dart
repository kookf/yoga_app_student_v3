import 'package:flutter/material.dart';
import 'package:yoga_student_app/common/colors.dart';

import '../components/counter_down_page.dart';
import '../components/slide_widget.dart';
import 'package:get/get.dart';
class SignClassPage extends StatefulWidget {
  const SignClassPage({Key? key}) : super(key: key);

  @override
  State<SignClassPage> createState() => _SignClassPageState();
}

class _SignClassPageState extends State<SignClassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColor.themeColor,
      //   title: Text('上課簽到',style: TextStyle(color: AppColor.themeTextColor,fontSize: 18),),
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
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 35),
                    child:IconButton(onPressed: (){
                      Get.back();
                    }, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 35),
                    child: const Text('上課簽到',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                  ),
                ],
              )
          ),

          SizedBox(height: 15,),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                color: AppColor.themeColor,
                borderRadius: BorderRadius.all(Radius.circular(60))
            ),
            child: FlutterLogo(size: 100,),
          ),
          SizedBox(height: 25,),
          Text('李家強老師課堂',style: TextStyle(color: AppColor.themeTextColor,fontSize: 24),),
          SizedBox(height: 25,),

          Text('距離上課時間還剩',style: TextStyle(color: AppColor.themeTextColor,fontSize: 18),),
          SizedBox(height: 25,),
          CounterDownPage(60),
          Center(
            child: Container(
              // width: Get.width-100,
              child:SlideVerifyWidget(
                height: 60,
                backgroundColor: AppColor.themeColor,
                borderColor: AppColor.themeColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
