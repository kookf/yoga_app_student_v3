import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:yoga_student_app/common/colors.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/pages/payment_method_modules/payment_method_model.dart';
import 'package:yoga_student_app/pages/payment_method_modules/upload_receipt_page.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';
import 'package:yoga_student_app/utils/hex_color.dart';

import 'charge_code_model.dart';
class PayMethodPage extends StatefulWidget {
  const PayMethodPage({Key? key}) : super(key: key);

  @override
  State<PayMethodPage> createState() => _PayMethodPageState();
}

class _PayMethodPageState extends State<PayMethodPage> {


  PaymentMethodModel? paymentMethodModel;

  TextEditingController codeTextEditingController = TextEditingController();

  requestDataWithChargeType()async{
    var params = {
      'method':'charge.type',
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams:params);

    PaymentMethodModel model = PaymentMethodModel.fromJson(json);

    paymentMethodModel = model;

    setState(() {

    });
  }
  /// 获取优惠方式
  ChargeCodeModel? chargeCodeModel;
  requestDataWithChargeCode(var code)async{
    var params = {
      'method':'charge.code',
      'code':code,
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams:params);

    ChargeCodeModel model = ChargeCodeModel.fromJson(json);


    if(model.code == 200){
      BotToast.showText(text: '已使用優惠碼');
    }else{
      BotToast.showText(text: model.message!);
      return;
    }

    if(model.data!.useNum==0){
      chargeCodeModel = model;
    }else if(model.data!.useNum!>0&&model.data!.usedNum! >= model.data!.useNum!){
      BotToast.showText(text: '優惠券不可用');
    }


    setState(() {

    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDataWithChargeType();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColor.themeColor,
        title: const Text('付款方式'),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.themeColor,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(20)),
            ),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(18))
                    ),
                    width: Get.width-100,
                    height: 35,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 15),
                    child: TextField(
                      controller: codeTextEditingController,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: '輸入優惠碼',
                        hintStyle: TextStyle(color: AppColor.themeTextColor,fontSize: 18),
                      ),
                    ),
                  ),
                ),
                TextButton(onPressed: (){
                  print(codeTextEditingController.text);
                  if(codeTextEditingController.text.isEmpty){
                    BotToast.showText(text: '請輸入優惠碼');
                    return;
                  }
                  requestDataWithChargeCode(codeTextEditingController.text);
                }, child: Text('確定',style: TextStyle(color: AppColor.themeTextColor),))
              ],
            ),
          ),

          Expanded(child: CustomScrollView(
            slivers: [
              SliverList(delegate: _mySliverChildBuilderDelegate())
            ],
          )),
          const SizedBox(height: 15,),
          Center(
            child: Text('如欲使用Payme付款可與客服聯繫',style: TextStyle(color: AppColor.themeTextColor),),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              width: Get.width-30,
              child: Row(
                children: [
                  Container(
                    height: 24,
                    width: 5,
                    color: HexColor('#343679'),
                  ),
                  const SizedBox(width: 3,),
                  Text('退款政策',style: TextStyle(fontSize: 21,color: AppColor.themeTextColor),),
                ],
              )
            ),
          ),
          Container(

              margin: const EdgeInsets.only(top: 15,left: 35,right: 35),
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
  SliverChildBuilderDelegate _mySliverChildBuilderDelegate(){
    return SliverChildBuilderDelegate((context, index) {

      PaymentMethodList model = paymentMethodModel!.data!.list![index];
      return GestureDetector(
        onTap: (){
          Get.to(UpLoadReceiptPage(model.id!,codeTextEditingController.text));
          // Get.to(ReceiptPage());
        },
        child:Center(
          child: Container(
            width: Get.width-20,
            margin: const EdgeInsets.only(top: 15),
            height: 70,
            padding: const EdgeInsets.only(left: 5,right: 5),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                      Image.asset('images/ic_payment_fps.png',width: 35,height: 35,),
                     Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('${model.name}',style: TextStyle(fontSize: 20,color: AppColor.themeTextColor),),
                         model.isShareWallet==0?Text('正常钱包充值',style: TextStyle(fontSize: 12,color: AppColor.themeTextColor),):
                         Text('共享錢包充值',style: TextStyle(fontSize: 12,color: AppColor.themeTextColor),),
                       ],
                     ),
                      Image.asset('images/ic_mine_jinbi.png',width: 25,height: 25,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${model.gold}'),
                         chargeCodeModel?.data?.gold==null? SizedBox():Text('+${chargeCodeModel?.data?.gold}')
                        ],
                      )
                    ],
                  ),

                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('HK\$${model.amount}',style: TextStyle(fontSize: 20,color: AppColor.themeTextColor),),
                        chargeCodeModel?.data?.cash==null? SizedBox():Text('-HK\$${chargeCodeModel?.data?.gold}',style: TextStyle(
                          color: AppColor.themeTextColor
                        ),)

                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,color: AppColor.themeColor,size: 15,)
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },childCount: paymentMethodModel?.data?.list?.length??0);
  }

}
