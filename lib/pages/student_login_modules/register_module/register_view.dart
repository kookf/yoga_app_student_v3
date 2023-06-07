import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/lang/message.dart';
import 'package:yoga_student_app/pages/student_login_modules/register_module/register_controller.dart';
import '../../../common/colors.dart';
import '../../mine_modules/privacy_page.dart';

class RegisterView extends GetView {
  @override
  final RegisterController controller = Get.put(RegisterController());

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<RegisterController>(builder: (_) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 25),
                alignment: Alignment.center,
                child: Text(
                  I18nContent.studentRegisterLabel,
                  style: TextStyle(
                      fontSize: 31,
                      color: AppColor.themeColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: 15),
                  width: Get.width - 50,
                  //边框设置
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border: Border.all(
                        width: 1, color: AppColor.textFieldBorderColor),
                  ),
                  child: TextField(
                    controller: controller.nameTextEditingController,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(13) //限制长度
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: I18nContent.userNameLabel),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: 15),
                  width: Get.width - 50,
                  //边框设置
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border: Border.all(
                        width: 1, color: AppColor.textFieldBorderColor),
                  ),
                  child: TextField(
                    controller: controller.emailTextEditingController,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(50) //限制长度
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: I18nContent.emailLabel),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: 15),
                  width: Get.width - 50,
                  //边框设置
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border: Border.all(
                        width: 1, color: AppColor.textFieldBorderColor),
                  ),
                  child: TextField(
                    controller: controller.phoneTextEditingController,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20) //限制长度
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: I18nContent.userPhoneLabel),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),

              const SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: 15),
                  width: Get.width - 50,
                  //边框设置
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border: Border.all(
                        width: 1, color: AppColor.textFieldBorderColor),
                  ),
                  child: TextField(
                    obscureText: true,
                    controller: controller.passwordTextEditingController,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(25) //限制长度
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: I18nContent.passwordLabel),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),

              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: 15),
                  width: Get.width - 50,
                  //边框设置
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border: Border.all(
                        width: 1, color: AppColor.textFieldBorderColor),
                  ),
                  child: TextField(
                    obscureText: true,
                    controller: controller.passwordConfirmationController,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(25) //限制长度
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: I18nContent.enterPasswordLabel),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 30, top: 15),
                child: Text(
                  '生日（選填）',
                  style: TextStyle(color: AppColor.themeColor),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      color: Colors.white,
                      height: 230 + kBottomNavigationBarHeight,
                      alignment: Alignment.bottomCenter,
                      child: DateTimePickerWidget(
                        minDateTime: DateTime.parse('1900-01-01'),
                        maxDateTime: DateTime.parse('2099-11-25'),
                        initDateTime: DateTime.now(),
                        dateFormat: 'yyyy-MM-dd',
                        pickerTheme: DateTimePickerTheme(
                          // showTitle: false,
                          backgroundColor: AppColor.themeColor,
                        ),
                        onChange: (dateTime, selectedIndex) {
                          // setState(() {
                          //   _dateTime = dateTime;
                          // });
                        },
                        onConfirm: (dateTime, selectedIndex) {
                          String dateStr =
                              '${dateTime.year}-${dateTime.month}-${dateTime.day}';
                          print('confirm ${dateStr}');
                          controller.birth = dateStr;
                          controller.birthController.text = dateStr;
                          controller.update();
                        },
                      ),
                    ),
                  );

                  // Get.bottomSheet(DatePickerBottomSheet());
                  // DatePicker.showDatePicker(context,
                  //     showTitleActions: true,
                  //     minTime: DateTime(1980, 1, 1),
                  //     maxTime: DateTime(2099, 6, 7),
                  //     theme: DatePickerTheme(
                  //         headerColor: AppColor.themeColor,
                  //         backgroundColor: AppColor.themeColor,
                  //         itemStyle: const TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 18),
                  //         doneStyle:
                  //         const TextStyle(color: Colors.white, fontSize: 16)),
                  //     onChanged: (date) {
                  //
                  //     }, onConfirm: (date) {
                  //
                  //       String dateStr = '${date.year}-${date.month}-${date.day}';
                  //       print('confirm ${dateStr}');
                  //       controller.birth = dateStr;
                  //       controller.birthController.text = dateStr;
                  //       controller.update();
                  //   }, currentTime: DateTime(1998),);
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.only(left: 15),
                    width: Get.width - 50,
                    //边框设置
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //设置四周圆角 角度
                      borderRadius:
                      const BorderRadius.all(Radius.circular(8.0)),
                      //设置四周边框
                      border: Border.all(
                          width: 1, color: AppColor.textFieldBorderColor),
                    ),
                    child: TextField(
                      enabled: false,
                      controller: controller.birthController,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(25) //限制长度
                      ],
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '出生日期（年/月/日）',
                          hintStyle: TextStyle(color: AppColor.themeColor)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),

              Padding(
                padding: const EdgeInsets.only(left: 30, top: 15),
                child: Text(
                  I18nContent.addressLabel,
                  style: TextStyle(color: AppColor.themeColor),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: 15),
                  width: Get.width - 50,
                  height: 100,
                  //边框设置
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border: Border.all(
                        width: 1, color: AppColor.textFieldBorderColor),
                  ),
                  child: TextField(
                    controller: controller.addressController,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(100) //限制长度
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: I18nContent.addressLabel),
                    maxLines: 2,
                  ),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              GestureDetector(
                onTap: () => controller.tapClickRegister(),
                child: Center(
                  child: Container(
                    height: 45,
                    width: Get.width - 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: AppColor.themeColor,
                    ),
                    child: const Text(
                      I18nContent.registerUserLabel,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Center(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(value: controller.check, onChanged: (value){
                      controller.check =! controller.check;
                      controller.update();
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

              const SizedBox(
                height: 80,
              ),

              // Container(
              //   // color: Colors.red,
              //   alignment: Alignment.bottomCenter,
              //   child: Image.asset(
              //     'images/yuyuebg.png',
              //     fit: BoxFit.fill,
              //   ),
              // )

            ],
          ),
        );
      }),
    );
  }
}
