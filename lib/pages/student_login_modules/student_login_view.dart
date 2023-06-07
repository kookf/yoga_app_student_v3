import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:yoga_student_app/components/my_webview.dart';
import 'package:yoga_student_app/lang/message.dart';
import 'package:yoga_student_app/pages/mine_modules/privacy_page.dart';
import 'package:yoga_student_app/pages/student_login_modules/student_login_controller.dart';
import 'package:yoga_student_app/utils/persistent_storage.dart';
import '../../common/app_theme.dart';
import '../../common/colors.dart';
import '../../router/app_pages.dart';
import 'package:get/get.dart';
class StudentLoginView extends GetView {
  StudentLoginView({super.key});

  @override
  final StudentController controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<StudentController>(builder: (_) {
        return ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const SizedBox(
              height: 0,
            ),
            Stack(
              children: [
                Image.asset(
                  'images/login_bg.png',
                  fit: BoxFit.fill,
                  width: Get.width,
                  height: 500,
                ),

                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(
                      left: 15, top: MediaQuery.of(context).padding.top + 40),
                  child: Text(
                    'Hello!',
                    style: TextStyle(fontSize: 31, color: AppColor.themeColor),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 60),
                    // color: Colors.redAccent,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/login_log.png',
                          width: 260,
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 20),
                            alignment: Alignment.center,
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                                color: AppColor.themeColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: const Text(
                              I18nContent.versionLabel,
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    )),
                // Container(
                //   margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+360),
                //   color: Colors.transparent,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Image.asset('images/left_mifeng.png',fit: BoxFit.contain,),
                //       SizedBox(width: 70,),
                //       Image.asset('images/right_mifeng.png',fit: BoxFit.contain,),
                //     ],
                //   ),
                // )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.redAccent,
                  width: Get.width,
                  alignment: const Alignment(-0.75, -1),
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    I18nContent.loginInLabel,
                    style: appThemeData.textTheme.bodyText1!
                        .copyWith(fontSize: 25, color: AppColor.themeColor),
                  ),
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
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
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
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
                      controller: controller.passwordTextEditingController,
                      obscureText: true,
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
                  height: 15,
                ),
                Center(
                  child: LoadingBtn(
                    height: 50,
                    borderRadius: 8,
                    animate: true,
                    color: AppColor.themeColor,
                    width: MediaQuery.of(context).size.width * 0.45,
                    loader: Container(
                      padding: const EdgeInsets.all(10),
                      width: 40,
                      height: 40,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    child: const Text(I18nContent.loginInLabel),
                    onTap: (startLoading, stopLoading, btnState) async {
                      if(controller.check==false){
                        BotToast.showText(text: '請同意隱私政策');
                        return;
                      }
                      if (btnState == ButtonState.idle) {
                        if (controller
                            .emailTextEditingController.text.isEmpty) {
                          BotToast.showText(
                              text: I18nContent.errorEmailAddressNotEmpty);
                          return;
                        }
                        if (controller
                            .passwordTextEditingController.text.isEmpty) {
                          BotToast.showText(
                              text: I18nContent.errorPassWordNotEmpty);
                          return;
                        }
                        startLoading();

                        controller
                            .requestDataWithLogin()
                            .then((value) async => {
                                  if (value['code'] == 200)
                                    {
                                      await PersistentStorage().setStorage(
                                          'token', value['data']['token']),
                                      // Get.offAll(const Tabs()),
                                      Get.offAllNamed(AppRoutes.bottomMain),
                                      stopLoading(),
                                      BotToast.showText(
                                          text: I18nContent.loginInSuccessLabel)
                                    }
                                  else
                                    {
                                      BotToast.showText(
                                          text: '${value['message']}'),
                                      stopLoading(),
                                    }
                                });

                        // await Future.delayed(const Duration(seconds: 2));

                        // Get.offAll(const Tabs());
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                    child: Text(
                  I18nContent.notUserLabel,
                  style: TextStyle(color: AppColor.themeColor),
                )),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.register);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        color: AppColor.registerBgColor,
                      ),
                      width: Get.width - 150,
                      height: 35,
                      alignment: Alignment.center,
                      child: const Text(
                        I18nContent.createNewAccLabel,
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
                  height: 50,
                )
              ],
            ),
          ],
        );
      }),
    );
  }
}
