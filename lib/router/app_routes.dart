
import 'package:yoga_student_app/pages/bottom_nav_moudules/bottom_tab_controller.dart';
import 'package:yoga_student_app/pages/classroom_modules/classtime_view.dart';

import '../pages/classroom_modules/classroom_view.dart';
import '../pages/sign_class_page.dart';
import '../pages/student_login_modules/register_module/register_view.dart';
import '../pages/student_login_modules/student_login_view.dart';
import 'app_pages.dart';
import 'package:get/get.dart';

class AppPages {

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => StudentLoginView(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterView(),
    ),
    GetPage(
      name: AppRoutes.classroom,
      page: () => ClassroomView(),
    ),
    GetPage(
      name: AppRoutes.classtime,
      page: () => ClassTimeView(),
    ),
    GetPage(
      name: AppRoutes.signClass,
      page: () => SignClassPage(),
    ),
    GetPage(
      name: AppRoutes.bottomMain,
      page: () => TabPage(),
    ),
    //
    // GetPage(
    //   name: AppRoutes.teacherRegister,
    //   page: () => TeacherRegisterView(),
    // ),
    //
    // GetPage(
    //   name: AppRoutes.joinClass,
    //   page: () => JoinClassView(),
    // ),
  ];
}