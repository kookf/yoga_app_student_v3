import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../services/address.dart';
import '../../../services/dio_manager.dart';

class RegisterController extends GetxController {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? birth;
  bool check = true;

  /// 注冊请求
  Future requestDataWithRegister() async {
    var params = {
      'method': 'auth.create',
      'name': nameTextEditingController.text,
      'email': emailTextEditingController.text,
      'phone': phoneTextEditingController.text,
      'password': passwordTextEditingController.text,
      'password_confirmation': passwordConfirmationController.text,
      'birth': birth,
      'optional': addressController.text,
      'is_teacher': '0',
    };
    var json = await DioManager().kkRequest(
      Address.host,
      bodyParams: params,
    );

    if (json['code'] == 200) {
      BotToast.showText(text: '註冊成功');
      Get.back();
    }
    return json;
  }

  tapClickRegister() async {
    if (!GetUtils.isEmail(emailTextEditingController.text)) {
      BotToast.showText(text: '請輸入正確的電郵');
      return;
    }
    if (passwordTextEditingController.text.length < 5) {
      BotToast.showText(text: '密碼過於簡單');
      return;
    }
    requestDataWithRegister();
  }
}
