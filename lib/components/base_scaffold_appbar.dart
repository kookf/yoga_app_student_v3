import 'package:flutter/material.dart';
import '../common/colors.dart';
import 'package:get/get.dart';
class BaseAppBar extends PreferredSize{
  /// 公共导航条
  ///
  final List<Widget>? action;
  const BaseAppBar({super.key, required super.child, required super.preferredSize,this.action});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  AppBar(
      actions: action,
      backgroundColor: AppColor.themeColor,
      title: child,
      leading: IconButton(
        onPressed: () async{
          Get.back();
        },
        icon: Image.asset(
          'images/leftarr.png',
          color: Colors.white,
          width: 15,
          height: 15,
        ),
      ),
    );
  }

}