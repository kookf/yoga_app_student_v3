import 'dart:ui';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yoga_student_app/pages/home_modules/home_index_model.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';

class HomeController extends GetxController {
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
  requestDataWithHomeIndex() async {
    var params = {
      'method': 'home.index',
    };
    var json = await DioManager().kkRequest(Address.host, bodyParams: params);

    HomeIndexModel model = HomeIndexModel.fromJson(json);

    homeIndexModel = model;

    update();
  }

  late final WebViewController webViewController;
  String kLocalExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body>

<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d922.9562977943007!2d114.19147662852646!3d22.284610739665812!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3404018fe63f36ef%3A0x3f0199c7ad8f39c!2z5ZKq5pGp55Gc5Ly9!5e0!3m2!1szh-TW!2shk!4v1681625214996!5m2!1szh-TW!2shk" width="1000" height="500" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>


</body>
</html>
''';
  @override
  void onInit() {
    super.onInit();
    requestDataWithHomeIndex();

    // webViewController = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         if (request.url.startsWith('https://www.youtube.com/')) {
    //           return NavigationDecision.prevent;
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadHtmlString(kLocalExamplePage);
  }
}
