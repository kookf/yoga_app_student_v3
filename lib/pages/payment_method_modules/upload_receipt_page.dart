import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:yoga_student_app/common/colors.dart';
import 'package:yoga_student_app/lang/message.dart';
import 'package:yoga_student_app/pages/payment_method_modules/payment_complete_model.dart';
import 'package:yoga_student_app/utils/hex_color.dart';
import '../../services/address.dart';
import '../../services/dio_manager.dart';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'dart:io';
import '../../utils/app_util.dart';
import 'receipt_page.dart';

class UpLoadReceiptPage extends StatefulWidget {

  final int chargeId;

  final String code;

  final double amount;

  const UpLoadReceiptPage(this.chargeId,this.code,this.amount,{Key? key}) : super(key: key);

  @override
  State<UpLoadReceiptPage> createState() => _UpLoadReceiptPageState();
}

class _UpLoadReceiptPageState extends State<UpLoadReceiptPage> {

  List listFilePaths = [];

  /// 獲取文件地址
  Future requestDataWithPath()async{

    if(listFilePaths.isEmpty){
      BotToast.showText(text: I18nContent.pleaseSelectUploadImage);
      return;
    }
    MultipartFile multipartFile = MultipartFile.fromFileSync(
      '${listFilePaths[0].path}',filename: 'image.png',
    );

    FormData formData = FormData.fromMap({
      'dir':'charge',
      'type':'image',
      'file':multipartFile,
    });
    var json = await DioManager().kkRequest(Address.upload,bodyParams:formData);
    return json;
  }
  ///
  requestDataWithChargeCreate(chargeId,image, {code})async{
    var params = {
      'method':'charge.create',
      'charge_id':chargeId,
      'image':image,
      'code':code,
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params,isShowLoad: true);
    if(json['code'] == 200){
      PaymentCompleteModel model = PaymentCompleteModel.fromJson(json);
      Get.to(ReceiptPage(widget.amount,model));
    }else{
      BotToast.showText(text: json['message']);
    }
  }

  /// 上传图片
  selectImages() async {
    try {
      // _galleryMode = GalleryMode.image;
      // listFilePaths = await ImagePickers.pickerPaths(
      //   galleryMode: GalleryMode.image,
      //   showGif: false,
      //   selectCount: 1,
      //   showCamera: false,
      //   cropConfig: CropConfig(enableCrop: true, height: 1, width: 1),
      //   compressSize: 300,
      //   uiConfig: UIConfig(
      //     uiThemeColor: AppColor.themeColor,
      //   ),
      // );

      ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        showGif: false,
        selectCount: 1,
        showCamera: true,
        cropConfig: CropConfig(enableCrop: true, height: 1, width: 1),
        compressSize: 50,
        uiConfig: UIConfig(
          uiThemeColor: AppColor.themeColor,
        ),
      ).then((value) {
        listFilePaths.clear();
        listFilePaths.addAll(value);
        print(listFilePaths.length);
        // if (listFilePaths.length > 0) {
        //   MultipartFile multipartFile = MultipartFile.fromFileSync(
        //     '${listFilePaths![0].path}',filename: 'avator_userinfo',
        //   );
        //   requestDataWithUpdataInfo(avatar: multipartFile);
        //   listFilePaths!.forEach((media) {
        //     print('media.path.toString() ==== ${media.path.toString()}');
        //   });
        // }
        setState(() {

        });
      });


    } on PlatformException {
      BotToast.showText(text: 'error');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.themeColor,
        title: const Text(I18nContent.uploadReceipt),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.themeColor,
              borderRadius:const BorderRadius.only(bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(20)),
            ),
            height: 50,
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18))
                ),
                width: Get.width-100,
                height: 20,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 15),
              ),
            ),
          ),
          Expanded(child: ListView(
            children: [

              Container(
                // color: Colors.red,
                  width: Get.width,
                  height: 120,
                  padding: const EdgeInsets.only(right: 15,left: 15,top: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(I18nContent.uploadReceipt,
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,
                          color: AppColor.themeTextColor),),
                      Row(
                        children: [
                          const Text('需支付:'),
                          const SizedBox(width: 5,),
                          // Image.asset('images/ic_mine_jinbi.png',width: 45,height: 45,),
                          // SizedBox(width: 8,),
                          Text('HK\$${widget.amount}',style: TextStyle(color: AppColor.themeTextColor,
                              fontSize: 26,fontWeight: FontWeight.w700),),
                        ],
                      )
                    ],
                  )
              ),
              const SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  selectImages();
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.8,
                          color: AppColor.themeColor
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    width: Get.width-45,
                    height: 300,
                    child: Column(
                      children: [
                        const SizedBox(height: 15,),
                        Image.asset('images/ic_payment_fps.png'),
                        Container(
                            decoration: BoxDecoration(
                              color: HexColor('#F3F4F9'),
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                            ),
                            margin: const EdgeInsets.only(left: 15,right: 15),
                            height: 120,
                            width: Get.width,
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                listFilePaths.isNotEmpty?Image.file(File(listFilePaths[0].path!),width: 80,
                                  height: 80,):Image.asset('images/ic_upload_camera.png',width: 50,height: 50,),
                                Text(I18nContent.uploadImage,style: TextStyle(color: AppColor.themeTextColor),)
                              ],
                            )
                        ),
                        Container(
                          margin: const EdgeInsets.only(top:15 ),
                          width: 150,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            color: AppColor.themeColor,
                          ),
                          child: TextButton(
                            onPressed: () {
                              requestDataWithPath().then((value) {
                                if(value['code'] == 200){
                                  requestDataWithChargeCreate(widget.chargeId,
                                      value['data']['path'],code: widget.code);
                                }
                              });

                            },
                            child: const Text(I18nContent.sendOut,
                              style: TextStyle(color: Colors.white,fontSize: 18,
                                fontWeight: FontWeight.w700
                            ),),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 5,),
              Center(
                child: Text('FPS識別代碼',style: TextStyle(color: AppColor.themeTextColor,
                    fontSize: 18,fontWeight: FontWeight.w600),),
              ),
              const SizedBox(height: 5,),

              GestureDetector(
                onLongPress: (){
                  AppUtil.saveImage('images/ic_paycode.png',isAsset: true);
                },
                child: Center(
                  child: Image.asset('images/ic_paycode.png',width: 150,height: 150,),
                ),
              ),
              Center(
                child: SelectableText('長按可複製 165932872',style: TextStyle(color: AppColor.themeTextColor),),
              ),

              const SizedBox(height: 15,),

              Center(
                child: Text('如欲使用 Payme 付款可與客服聯繫',style: TextStyle(color: AppColor.themeTextColor),),
              ),

//           Center(
//             child: Container(
//                 margin: EdgeInsets.only(top: 30),
//                 width: Get.width-30,
//                 child: Row(
//                   children: [
//                     Container(
//                       height: 24,
//                       width: 5,
//                       color: HexColor('#343679'),
//                     ),
//                     SizedBox(width: 3,),
//                     Text('退款政策',style: TextStyle(fontSize: 21,color: AppColor.themeTextColor),),
//                   ],
//                 )
//             ),
//           ),
//           Container(
//
//               margin: EdgeInsets.only(top: 15,left: 35,right: 35),
//               child: Column(
//                 children: [
//                   Text('''momo yoga 可能惠威部分購買交易退款,視乎下述的退款的政策而定。您亦可以直接聯繫開發人員,
// 如果朋友或家庭成員意外使用了您的賬戶購物，請在 momo yoga網站要求退款。
//                   ''',style: TextStyle(fontSize: 12,color: AppColor.themeTextColor),),
//                 ],
//               )
//           ),

            ],
          ),),
        ],
      )
    );
  }
}
