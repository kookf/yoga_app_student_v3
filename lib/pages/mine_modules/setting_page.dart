import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/lang/message.dart';
import 'package:yoga_student_app/pages/mine_modules/user_model.dart';
import '../../common/colors.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../services/address.dart';
import '../../services/dio_manager.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController birthTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();



  /// 當前個人資料
  // UserModel? userModel;

  void requestDataWithUserinfo()async {
    var params = {
      'method': 'auth.profile',
    };
    var json = await DioManager().kkRequest(
        Address.hostAuth, bodyParams: params);

    UserModel userModel = UserModel.fromJson(json);

    nameTextEditingController.text = '${userModel.data?.name}';
    phoneTextEditingController.text = '${userModel.data?.phone}';
    birthTextEditingController.text = '${userModel.data?.birth}';
    addressTextEditingController.text = '${userModel.data?.optional}';
    setState(() {

    });
  }
  ///修改個人資料
  void requestDataWithSave()async{
    var params = {
      'method': 'auth.save',
      'name':nameTextEditingController.text,
      'birth':birthTextEditingController.text,
      'phone':phoneTextEditingController.text,
      'optional':addressTextEditingController.text,
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    if(json['code'] == 200){
      BotToast.showText(text: '修改成功');
      Get.back();
    }else{
      BotToast.showText(text: json['message']);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDataWithUserinfo();
  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
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
                    padding: const EdgeInsets.only(top: 35),
                    child:IconButton(onPressed: (){
                      Get.back(result: 'refresh');
                    }, icon: const Icon(Icons.arrow_back_ios),color: Colors.white,),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 35),
                    child: const Text(I18nContent.bottomSettingLabel,
                      style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                  ),
                ],
              )
          ),
          Expanded(child:  ListView(
            padding: EdgeInsets.all(0),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 35,),
              Center(
                child: Text(I18nContent.changeCurrentProfile,
                  style: TextStyle(color: AppColor.themeTextColor,fontSize: 21,fontWeight: FontWeight.w700),),
              ),
              const SizedBox(height: 15,),
              Padding(padding: const EdgeInsets.only(left: 30,),
                child: Text('用戶名稱/電聯',style: TextStyle(color: AppColor.themeColor),),),
              Center(
                child:  Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: 15),
                  width: Get.width-50,
                  //边框设置
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                  ),
                  child: TextField(
                    controller: nameTextEditingController,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(15) //限制长度
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '當前名稱'
                    ),
                  ),
                ),
              ),

              // Padding(padding: const EdgeInsets.only(left: 30,top: 15),child: Text('用戶電話',style: TextStyle(color: AppColor.themeColor),),),
              // Center(
              //   child:  Container(
              //     margin: const EdgeInsets.only(top: 5),
              //     padding: const EdgeInsets.only(left: 15),
              //     width: Get.width-50,
              //     //边框设置
              //     decoration:  BoxDecoration(
              //       color: Colors.white,
              //       //设置四周圆角 角度
              //       borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              //       //设置四周边框
              //       border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
              //     ),
              //     child: TextField(
              //       controller: phoneTextEditingController,
              //       inputFormatters: <TextInputFormatter>[
              //         LengthLimitingTextInputFormatter(15) //限制长度
              //       ],
              //       decoration: const InputDecoration(
              //           border: InputBorder.none,
              //           hintText: '用戶電話'
              //       ),
              //     ),
              //   ),
              // ),

              Padding(padding: const EdgeInsets.only(left: 30,top: 15),child: Text('出生日期（年/月/日）',style: TextStyle(color: AppColor.themeColor),),),
              GestureDetector(
                onTap: (){
                  DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1950, 1, 1),
                    maxTime: DateTime(2099, 6, 7),
                    theme: DatePickerTheme(
                        headerColor: AppColor.themeColor,
                        backgroundColor: AppColor.themeColor,
                        itemStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        doneStyle:
                        const TextStyle(color: Colors.white, fontSize: 16)),
                    onChanged: (date) {

                    }, onConfirm: (date) {
                      String dateStr = '${date.year}-${date.month}-${date.day}';
                      // controller.birth = dateStr;
                      birthTextEditingController.text = dateStr;
                      // controller.update();
                    }, currentTime: DateTime.now(),);
                },
                child: Center(
                  child:Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.only(left: 15),
                    width: Get.width-50,
                    //边框设置
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      //设置四周圆角 角度
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      //设置四周边框
                      border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                    ),
                    child: TextField(
                      enabled: false,
                      controller: birthTextEditingController,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(25) //限制长度
                      ],
                      decoration:  InputDecoration(
                          border: InputBorder.none,
                          hintText: I18nContent.birthdayLabel,
                          hintStyle: TextStyle(color: AppColor.themeColor)
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(left: 30,top: 15),
                child: Text(I18nContent.addressLabel,style: TextStyle(color: AppColor.themeColor),),),
              Center(
                child:  Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: 15),
                  width: Get.width-50,
                  height: 100,
                  //边框设置
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                  ),
                  child: TextField(
                    controller: addressTextEditingController,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(100) //限制长度
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: I18nContent.addressLabel
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
              const SizedBox(height: 35,),
              GestureDetector(
                onTap: (){
                  requestDataWithSave();
                },
                child:  Center(
                  child:Container(
                    height: 45,
                    width: Get.width -50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: AppColor.themeColor,
                    ),
                    child: const Text(I18nContent.sendOut,style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              const SizedBox(height: 50,)

            ],
          ),),
        ],
      )

    );
  }
}
