import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';
import '../../common/colors.dart';
import '../../common/eventbus.dart';
import '../../utils/hex_color.dart';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';

class ChangeAvatarPage extends StatefulWidget {

   final String headerUrl;

   const ChangeAvatarPage(this.headerUrl,{Key? key}) : super(key: key);

  @override
  State<ChangeAvatarPage> createState() => _ChangeAvatarPageState();
}

class _ChangeAvatarPageState extends State<ChangeAvatarPage> {

  List<Media> listFilePaths = [];

  /// 獲取文件地址
  Future requestDataWithPath()async{

    if(listFilePaths.isEmpty){
      BotToast.showText(text: '請選擇上傳的圖片');
      return;
    }
    MultipartFile multipartFile = MultipartFile.fromFileSync(
      '${listFilePaths[0].path}',filename: 'header_image.png',
    );

    FormData formData = FormData.fromMap({
      'dir':'avatar',
      'type':'image',
      'file':multipartFile,
    });
    var json = await DioManager().kkRequest(Address.upload,bodyParams:formData,isShowLoad: true);
    return json;
  }
  /// 更新頭像
  requestDataWithUpdateAvatar(avatar)async{
    var params = {
      'method':'auth.update_avatar',
      'avatar':avatar,
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params,isShowLoad: true);
    if(json['code'] == 200){
      Get.back();
      BotToast.showText(text: '上傳成功');
    }else{
      BotToast.showText(text: json['message']);
    }

    eventBus.fire(EventFn('headerRefresh'));

  }

  /// 上传图片
  selectImages() async {
    try {
      ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        showGif: false,
        selectCount: 1,
        showCamera: true,
        cropConfig: CropConfig(enableCrop: true, height: 1, width: 1),
        compressSize: 300,
        uiConfig: UIConfig(
          uiThemeColor: AppColor.themeColor,
        ),
      ).then((value) {
        listFilePaths.clear();
        listFilePaths.addAll(value);

        setState(() {

        });
      });
    }catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).padding.top+kToolbarHeight,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColor.themeColor,
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 35),
                    child:IconButton(onPressed: (){
                      Get.back();
                    }, icon: const Icon(Icons.arrow_back_ios),color: Colors.white,),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 35),
                    child: const Text('更換頭像',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                  ),
                ],
              )
          ),

          Expanded(child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              const SizedBox(height: 25,),

              Center(
                child:  Container(
                  width: 160,
                  height: 160,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(80))
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.headerUrl,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 25,),

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
                    height: 210,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                                Text('上傳圖片',style: TextStyle(color: AppColor.themeTextColor),)
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
                                  requestDataWithUpdateAvatar(value['data']['path']);
                                }
                              });
                            },
                            child: const Text('送出',style: TextStyle(color: Colors.white,fontSize: 18,
                                fontWeight: FontWeight.w700
                            ),),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 170,),

              Container(

                alignment: Alignment.bottomCenter,
                width: Get.width,
                child: Image.asset('images/yuyuebg.png',fit: BoxFit.fill,),
              )
            ],
          ),),
        ],
      )
    );
  }
}
