import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';

class ApiManager {
  /// 网络请求
  static Future<dynamic> request(
      String url, Map<String, dynamic> params) async {
    var json = await DioManager()
        .kkRequest(url, bodyParams: params, isShowLoad: false);
    return json;
  }

  ///hostAuth 请求
  static Future<dynamic> requestWithHostAuth(
      Map<String, dynamic> params) async {
    var json = await request(Address.hostAuth, params);
    return json;
  }

  ///public 请求
  static Future<dynamic> requestWithPublic(Map<String, dynamic> params) async {
    var json = await request(
      Address.host,
      params,
    );
    return json;
  }

  /// 推出登录请求
  static Future<dynamic> requestWithLoginOut(
      Map<String, dynamic> params) async {
    var json = await request(Address.loginOut, params);
    return json;
  }
}
