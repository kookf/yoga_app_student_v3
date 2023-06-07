import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/router/app_pages.dart';
import '../../utils/persistent_storage.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  bool? isLogin;

  @override
  void initState() {
    getToken();
    super.initState();
  }

  getToken() async {
    print('token ======= ${await PersistentStorage().getStorage('token')}');
    if (await PersistentStorage().getStorage('token') == null) {
      isLogin = false;
      Get.offAllNamed(
        AppRoutes.login,
      );
    } else {
      isLogin = true;
      Get.offAllNamed(
        AppRoutes.bottomMain,
      );
    }
    print('islogin === ${isLogin}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
