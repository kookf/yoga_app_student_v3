import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/link.dart';
import 'package:yoga_student_app/common/colors.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/lang/message.dart';
import 'package:yoga_student_app/pages/payment_method_modules/payment_method_model.dart';
import 'package:yoga_student_app/pages/payment_method_modules/upload_receipt_page.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';
import '../mine_modules/privacy_page.dart';
import 'charge_code_model.dart';

class PayMethodPage extends StatefulWidget {
  final int type;

  const PayMethodPage(this.type, {Key? key}) : super(key: key);

  @override
  State<PayMethodPage> createState() => _PayMethodPageState();
}

class _PayMethodPageState extends State<PayMethodPage> {

  bool check = true;

  PaymentMethodModel? paymentMethodModel;

  TextEditingController codeTextEditingController = TextEditingController();

  requestDataWithChargeType() async {
    var params = {
      'method': 'charge.type',
    };
    var json =
        await DioManager().kkRequest(Address.hostAuth, bodyParams: params);

    PaymentMethodModel model = PaymentMethodModel.fromJson(json);

    paymentMethodModel = model;

    setState(() {});
  }

  /// 获取优惠方式
  ChargeCodeModel? chargeCodeModel;
  requestDataWithChargeCode(var code) async {
    var params = {
      'method': 'charge.code',
      'code': code,
    };
    var json =
        await DioManager().kkRequest(Address.hostAuth, bodyParams: params);

    ChargeCodeModel model = ChargeCodeModel.fromJson(json);

    if (model.code == 200) {
      chargeCodeModel = model;
      BotToast.showText(text: '已使用優惠碼');
    } else {
      BotToast.showText(text: model.message!);
      return;
    }

    if (model.data!.useNum == 0) {
      chargeCodeModel = model;
    } else if (model.data!.useNum! > 0 &&
        model.data!.usedNum! >= model.data!.useNum!) {
      BotToast.showText(text: '優惠券不可用');
    }

    setState(() {});
  }

  /// 获取警示
  String refundStr = '';
  requestDataWithRefund() async {
    var params = {
      'method': 'charge.refund',
    };
    var json =
        await DioManager().kkRequest(Address.hostAuth, bodyParams: params);
    refundStr = json['data']['refund'];
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDataWithChargeType();
    requestDataWithRefund();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColor.themeColor,
          title: const Text(I18nContent.paymentMethod),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColor.themeColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(20)),
                ),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        width: Get.width - 100,
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
                            hintStyle: TextStyle(
                                color: AppColor.themeTextColor, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          if (codeTextEditingController.text.isEmpty) {
                            BotToast.showText(
                                text: I18nContent.pleaseEnterDiscountsCode);
                            return;
                          }
                          requestDataWithChargeCode(
                              codeTextEditingController.text);
                        },
                        child: Text(
                          I18nContent.useDiscounts,
                          style: TextStyle(color: AppColor.themeTextColor),
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: CustomScrollView(
                slivers: [
                  paymentMethodModel == null
                      ? const SliverToBoxAdapter(
                          child: CupertinoActivityIndicator(),
                        )
                      : SliverList(delegate: _mySliverChildBuilderDelegate()),



                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Link(
                          uri: Uri.parse('https://wa.me/send?phone=852'
                              '55978331&text=%E6%88%91%E6%98%'
                              'AFMeMoYoga%E6%9C%83%E5%93%A1'
                              '%2C%20%E6%83%B3%E6%9F%A5%E8%A'
                              '9%A2Payme%E4%BB%98%E6%AC%BE%E6%96%B9%E6%B3%95%20'),
                          target: LinkTarget.blank,
                          builder: (BuildContext ctx, FollowLink? openLink) {
                            return TextButton.icon(
                              onPressed: openLink,
                              label: Text(
                                '如欲使用Payme付款可與客服聯繫 (按此查詢)',
                                style:
                                    TextStyle(color: AppColor.themeTextColor),
                                textAlign: TextAlign.center,
                              ),
                              icon: SizedBox(),
                            );
                          },
                        ),
                        // Center(
                        //   child: Text('如欲使用Payme付款可與客服聯繫 (按此查詢)',style: TextStyle(color: AppColor.themeTextColor),),
                        // ),
                        // Center(
                        //   child: Container(
                        //       margin: const EdgeInsets.only(top: 15),
                        //       width: Get.width-30,
                        //       child: Row(
                        //         children: [
                        //           Container(
                        //             height: 24,
                        //             width: 5,
                        //             color: HexColor('#343679'),
                        //           ),
                        //           const SizedBox(width: 3,),
                        //           Text('退款政策',style: TextStyle(fontSize: 21,color: AppColor.themeTextColor),),
                        //         ],
                        //       )
                        //   ),
                        // ),
                        Container(
                            margin: const EdgeInsets.only(
                                top: 15, left: 15, right: 15, bottom: 15),
                            child: Column(
                              children: [
                                HtmlWidget(refundStr),
                              ],
                            )),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child:    Center(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(value: check, onChanged: (value){
                            check =! check;
                            setState(() {

                            });
                          },checkColor: Colors.white,activeColor: AppColor.themeColor,),
                          Text.rich(
                            TextSpan(
                                text: '',
                                children: [
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()..onTap =(){
                                        Get.to(PrivacyPage());
                                      },
                                      text: ' 隱私政策',
                                      style: TextStyle(color: AppColor.themeTextColor,fontStyle: FontStyle.normal)
                                  )
                                ]
                            ),

                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ));
  }

  SliverChildBuilderDelegate _mySliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate((context, index) {
      PaymentMethodList model = paymentMethodModel!.data!.list![index];
      return model.isShareWallet == widget.type
          ? GestureDetector(
              onTap: () {
                if (chargeCodeModel == null) {
                  Get.to(UpLoadReceiptPage(
                      model.id!,
                      codeTextEditingController.text,
                      double.parse(model.amount!)));
                } else {
                  var amount = double.parse(model.amount!);
                  var codeAmount = double.parse(chargeCodeModel!.data!.cash!);
                  print(amount - codeAmount);
                  Get.to(UpLoadReceiptPage(model.id!,
                      codeTextEditingController.text, amount - codeAmount));
                }


                // Get.to(ReceiptPage());
              },
              child: Center(
                child: Container(
                  width: Get.width - 20,
                  margin: const EdgeInsets.only(top: 15),
                  // height: 70,
                  padding: const EdgeInsets.only(left: 15, right: 15,top: 15,bottom: 15),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border:
                          Border.all(width: 0.9, color: AppColor.themeColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width - 200,
                                child: Text(
                                  '${model.name}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColor.themeTextColor),
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(height: 15,),
                              // model.isShareWallet==0?Text('正常钱包充值',style: TextStyle(fontSize: 12,color: AppColor.themeTextColor),):
                              // Text('共享Credit充值',style: TextStyle(fontSize: 12,color: AppColor.themeTextColor),),
                              Row(
                                children: [
                                  Image.asset(
                                    'images/ic_mine_jinbi.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('${model.gold}'),
                                      chargeCodeModel?.data?.gold == null
                                          ? const SizedBox()
                                          : Text(
                                              ' +${chargeCodeModel?.data?.gold}',
                                              style: const TextStyle(
                                                  color: Colors.red),
                                            )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'HK\$${model.amount}',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: AppColor.themeTextColor),
                              ),
                              chargeCodeModel?.data?.cash == null
                                  ? const SizedBox()
                                  : Text(
                                      '-HK\$${chargeCodeModel?.data?.cash}',
                                      style:
                                          const TextStyle(color: Colors.green),
                                    )
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColor.themeColor,
                            size: 15,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox();
    }, childCount: paymentMethodModel?.data?.list?.length ?? 0);
  }
}
