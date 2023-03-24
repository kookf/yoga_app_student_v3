import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appThemeData = ThemeData(
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColor.themeColor,
    selectionColor:  AppColor.themeColor,
    selectionHandleColor:  AppColor.themeColor,

  ),
  hintColor: AppColor.themeColor,
  scaffoldBackgroundColor: AppColor.bgColor,
  appBarTheme: _appbarTheme(),
  iconTheme: const IconThemeData(
      color: Colors.blue
  ),
  textTheme:TextTheme(
      bodyText1: TextStyle(color: AppColor.textColor,fontSize: 16),
      subtitle1: TextStyle(color: AppColor.smallTextColor,fontSize: 12)
  ),

);

AppBarTheme _appbarTheme() {
  return  AppBarTheme(
    // centerTitle: true,
    // color: new Color.fromRGBO(38,116,251,1),
    backgroundColor: AppColor.bgColor,
    // color: HexColor('#2A39E1'),
    elevation: 0,
    titleTextStyle:  TextStyle(fontSize: 18,color: AppColor.themeTextColor,fontWeight: FontWeight.w500),
    iconTheme: const IconThemeData(color:Colors.black87),  // 图标

  );
}