import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/services/api_manager.dart';


class StudentController extends GetxController{


  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  /// 登录请求
  Future requestDataWithLogin()async{

    var params = {
      'method':'auth.login',
      'email':emailTextEditingController.text,
      'password':passwordTextEditingController.text,
      'is_teacher':'0',
    };

    var json = await ApiManager.requestWithPublic(params);

    // var json = await DioManager().kkRequest(Address.host,bodyParams: params);
    return json;
  }

}