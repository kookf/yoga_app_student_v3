import 'package:flutter/material.dart';
import 'package:yoga_student_app/common/colors.dart';
import 'package:get/get.dart';
class ReceiptPage extends StatefulWidget {
  const ReceiptPage({Key? key}) : super(key: key);

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.themeColor,
        title: const Text('收據'),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.themeColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(20)),
            ),
            height: 20,
          ),
          SizedBox(height: 15,),
          Text('已完成付款',style: TextStyle(fontSize: 25,color: AppColor.themeTextColor),),
          Image.asset('images/ic_receipt_success.png',width: 160,height: 160,),
          Text('HK\$ 500',style: TextStyle(fontSize: 30,color: AppColor.themeTextColor),),
          SizedBox(height: 15,),
          Text('付款給',style: TextStyle(color: AppColor.registerBgColor,fontSize: 14),),
          Center(
            child:Container(
              // color: Colors.red,
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/login_log.png',width: 55,height: 55,),
                  SizedBox(width: 5,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Momo Yoga',style: TextStyle(color: AppColor.themeTextColor,fontSize: 14),),
                      Text('info@momoyoga.com',style: TextStyle(color: AppColor.themeTextColor,fontSize: 14),),
                    ],
                  )
                ],
              ),
            )
          ),
          SizedBox(height: 15,),

          Text('Transaction Id',style: TextStyle(color: AppColor.themeTextColor,fontSize: 12),),
          SizedBox(height: 5,),
          Text('1234 5678 9012 4567',style: TextStyle(color: AppColor.themeTextColor,fontSize: 12),),

          SizedBox(height: 15,),
          Container(
            width: Get.width - 50,
            height: 45,
            child: MaterialButton(onPressed: (){

            },color: AppColor.themeColor,elevation: 0,shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
              child: Text('完成',style: TextStyle(color: Colors.white),),),
          ),
          SizedBox(height: 15,),
          Container(
            width: Get.width - 50,
            height: 45,
            child: MaterialButton(onPressed: (){

            },color: Colors.white,elevation: 0,shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                color: AppColor.themeColor,
                width: 1
              )
            ),
              child: Text('儲存收據',style: TextStyle(color: AppColor.themeTextColor),),),
          ),

        ],
      ),
    );
  }
}
