import 'package:get/get.dart';
import 'package:yoga_student_app/pages/home_modules/bannner_model.dart';
import 'package:yoga_student_app/pages/home_modules/home_index_model.dart';
import 'package:yoga_student_app/pages/home_modules/notice_model.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';

class HomeController extends GetxController{


  // BannerModel? model;
  //
  // ///獲取banner
  // requestDataWithBanner()async{
  //   var params = {
  //     'method':'banner.list',
  //   };
  //   var json = await DioManager().kkRequest(Address.host,bodyParams:params);
  //
  //   BannerModel bannerModel = BannerModel.fromJson(json);
  //
  //   model = bannerModel;
  //
  //   update();
  // }
  // /// 獲取公告
  //
  // NoticeModel? noticeModel;
  //
  // requestDataWithNotice()async{
  //   var params = {
  //     'method':'notice.list',
  //   };
  //   var json = await DioManager().kkRequest(Address.host,bodyParams:params);
  //
  //   NoticeModel model = NoticeModel.fromJson(json);
  //
  //   noticeModel = model;
  //
  //   update();
  // }

  /// home 數據
  HomeIndexModel? homeIndexModel;
  requestDataWithHomeIndex()async{
    var params = {
      'method':'home.index',
    };
    var json = await DioManager().kkRequest(Address.host,bodyParams:params);

    HomeIndexModel model = HomeIndexModel.fromJson(json);

    homeIndexModel = model;

    update();
  }


  @override
  void onInit() {
    super.onInit();
    requestDataWithHomeIndex();
  }


}