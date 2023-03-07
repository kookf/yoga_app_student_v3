import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/pages/mine_modules/user_model.dart';
import 'package:yoga_student_app/pages/student_login_modules/student_login_view.dart';
import 'package:yoga_student_app/router/app_pages.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';
import 'package:yoga_student_app/utils/persistent_storage.dart';

class MineController extends GetxController{


  List dataArr = [];


  UserModel? userModel;

  /// 獲取個人資料
  void requestDataWithUserinfo()async{

    var params = {
      'method':'auth.profile',
    };

    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);


    userModel = UserModel.fromJson(json);

    await PersistentStorage().setStorage('name', userModel!.data!.name);

    print(await PersistentStorage().getStorage('name'));

    update();

  }
  /// 退出登录
  void requestDataWithLoginOut()async{

    var json = await DioManager().kkRequest(Address.loginOut,isShowLoad: true);
    if(json['code'] == 200){
      await PersistentStorage().removeStorage('token');
      // Get.off(StudentLoginView());
      Get.offNamed(AppRoutes.login);
    }
    BotToast.showText(text: json['message']);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestDataWithUserinfo();
  }

}