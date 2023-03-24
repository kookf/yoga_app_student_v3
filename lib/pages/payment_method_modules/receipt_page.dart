import 'package:flutter/material.dart';
import 'package:yoga_student_app/common/colors.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/pages/payment_method_modules/payment_complete_model.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/utils/app_util.dart';


class ReceiptPage extends StatefulWidget {

  double amount;

  PaymentCompleteModel? model;

  ReceiptPage(this.amount,this.model,{Key? key}) : super(key: key);

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
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(20)),
            ),
            height: 20,
          ),
          const SizedBox(height: 15,),
          Text('已完成付款',style: TextStyle(fontSize: 25,color: AppColor.themeTextColor),),
          Image.asset('images/ic_receipt_success.png',width: 160,height: 160,),
          Text('HK\$ ${widget.model?.data?.amount}',style: TextStyle(fontSize: 30,color: AppColor.themeTextColor),),
          const SizedBox(height: 15,),
          Text('付款給',style: TextStyle(color: AppColor.registerBgColor,fontSize: 14),),
          Center(
            child:SizedBox(
              // color: Colors.red,
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/login_log.png',width: 55,height: 55,),
                  const SizedBox(width: 5,),
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
          const SizedBox(height: 15,),

          Text('Transaction Id',style: TextStyle(color: AppColor.themeTextColor,fontSize: 12),),
          const SizedBox(height: 5,),
          Text('${widget.model?.data?.orderNo}',style: TextStyle(color: AppColor.themeTextColor,fontSize: 12),),

          const SizedBox(height: 15,),
          SizedBox(
            width: Get.width - 50,
            height: 45,
            child: MaterialButton(onPressed: (){
              Get.back();
              Get.back();
            },color: AppColor.themeColor,elevation: 0,shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
              child: const Text('完成',style: TextStyle(color: Colors.white),),),
          ),
          const SizedBox(height: 15,),
          SizedBox(
            width: Get.width - 50,
            height: 45,
            child: MaterialButton(onPressed: (){

              AppUtil.saveImage('${Address.homeHost}/storage/${widget.model!.data!.image}');

            },color: Colors.white,elevation: 0,shape:RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
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
