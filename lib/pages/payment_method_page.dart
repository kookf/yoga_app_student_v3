import 'package:flutter/material.dart';
import 'package:yoga_student_app/common/colors.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/pages/receipt_page.dart';
import 'package:yoga_student_app/pages/upload_receipt_page.dart';
import 'package:yoga_student_app/utils/hex_color.dart';
class PayMethodPage extends StatefulWidget {
  const PayMethodPage({Key? key}) : super(key: key);

  @override
  State<PayMethodPage> createState() => _PayMethodPageState();
}

class _PayMethodPageState extends State<PayMethodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.themeColor,
        title: Text('付款方式'),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.themeColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(20)),
            ),
            height: 50,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18))
                ),
                width: Get.width-100,
                height: 35,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 15),
                child: TextField(
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: '輸入優惠碼',
                    hintStyle: TextStyle(color: AppColor.themeTextColor,fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          Container(
            // color: Colors.red,
            width: Get.width,
            height: 80,
            padding: EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('我的代幣'),
                SizedBox(width: 5,),
                Image.asset('images/ic_mine_jinbi.png',width: 45,height: 45,),
                SizedBox(width: 8,),
                Text('236',style: TextStyle(color: AppColor.themeTextColor,fontSize: 26,fontWeight: FontWeight.w700),),
              ],
            )
          ),

         GestureDetector(
           onTap: (){
             Get.to(UpLoadReceiptPage());
             Get.to(ReceiptPage());
           },
           child:Center(
             child: Container(
               width: Get.width-20,
               height: 70,
               padding: EdgeInsets.only(left: 15,right: 15),
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(12)),
                   border: Border.all(
                       width: 0.9,
                       color: AppColor.themeColor
                   )
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Row(
                     children: [
                       Image.asset('images/ic_payment_fps.png',width: 50,height: 50,),
                       Text('富貴逼人包',style: TextStyle(fontSize: 20,color: AppColor.themeTextColor),),
                       Image.asset('images/ic_mine_jinbi.png',width: 25,height: 25,),
                       Text('5000'),
                     ],
                   ),
                   Row(
                     children: [
                       Text('HK\$100',style: TextStyle(fontSize: 21,color: AppColor.themeTextColor),),
                       Icon(Icons.arrow_forward_ios,color: AppColor.themeColor,)
                     ],
                   )
                 ],
               ),
             ),
           ),
         ),
          SizedBox(height: 15,),
          Center(
            child: Container(
              width: Get.width-20,
              height: 70,
              padding: EdgeInsets.only(left: 15,right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(
                  width: 0.9,
                  color: AppColor.themeColor
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('images/ic_payment_fps.png',width: 50,height: 50,),
                      Text('富貴逼人包',style: TextStyle(fontSize: 20,color: AppColor.themeTextColor),),
                      Image.asset('images/ic_mine_jinbi.png',width: 25,height: 25,),
                      Text('5000'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('HK\$100',style: TextStyle(fontSize: 21,color: AppColor.themeTextColor),),
                      Icon(Icons.arrow_forward_ios,color: AppColor.themeColor,)
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 15,),
          Center(
            child: Text('如欲使用Payme付款可與客服聯繫',style: TextStyle(color: AppColor.themeTextColor),),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              width: Get.width-30,
              child: Row(
                children: [
                  Container(
                    height: 24,
                    width: 5,
                    color: HexColor('#343679'),
                  ),
                  SizedBox(width: 3,),
                  Text('退款政策',style: TextStyle(fontSize: 21,color: AppColor.themeTextColor),),
                ],
              )
            ),
          ),
          Container(

              margin: EdgeInsets.only(top: 15,left: 35,right: 35),
              child: Column(
                children: [
                  Text('''momo yoga 可能惠威部分購買交易退款,視乎下述的退款的政策而定。您亦可以直接聯繫開發人員,
如果朋友或家庭成員意外使用了您的賬戶購物，請在 momo yoga網站要求退款。
                  ''',style: TextStyle(fontSize: 12,color: AppColor.themeTextColor),),
                ],
              )
          ),
        ],
      ),
    );
  }
}
