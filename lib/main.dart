import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoga_student_app/pages/bottom_nav_moudules/guide_page.dart';
import 'package:yoga_student_app/router/app_routes.dart';
import 'common/app_theme.dart';


void main() {

  setCustomErrorPage();

  runApp(const MyApp());
}


class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }

}

void setCustomErrorPage() {

  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    return Container(
      color: Colors.white,
      child: const CupertinoActivityIndicator(),
    );
  };
}


class _MyAppState extends State<MyApp> {


  /// 百度地图的appkey
  static const String  appKey = 'IUkP2NbP8VOrlpl5tbEKAPszvk1w6GGt';


  /// 极光注册
  // connect()async{
  //
  //   JPush jpush = JPush();
  //
  //   jpush.applyPushAuthority(const NotificationSettingsIOS(
  //       sound: true,
  //       alert: true,
  //       badge: true));
  //
  //   jpush.setup(
  //     appKey: "a104990b599c92cd6c150596",
  //     channel: "theChannel",
  //     production: false,
  //     debug: true, // 设置是否打印 debug 日志
  //   );
  //   jpush.addEventHandler(
  //     // 接收通知回调方法。
  //     onReceiveNotification: (Map<String, dynamic> message) async {
  //       /// ios 接受到极光推送的方法
  //       debugPrint("flutter onReceiveNotification: $message");
  //       // var json = message['message'];
  //       // Get.snackbar('${json['msg_type']}', '${json['alert']}');
  //       // var localNotification = LocalNotification(
  //       //     id: 234,
  //       //     title: "本地推送",
  //       //     buildId: 1,
  //       //     content: "😁 随便写点内容，时间 ${DateTime.now().toIso8601String()}",
  //       //     fireTime: DateTime.now(), // 立即发送
  //       //     subtitle: "副标题 123456",
  //
  //       //     badge: 1,
  //       //     extra: {"myInfo": "推送信息balabla"} // 携带数据
  //       // );
  //       // jpush.sendLocalNotification(localNotification);
  //     },
  //
  //
  //     // 点击通知回调方法。
  //     onOpenNotification: (Map<String, dynamic> message) async {
  //
  //       /// ios 点击推送的方法
  //       jpush.setBadge(0);
  //       debugPrint("flutter onOpenNotification: $message");
  //
  //       if(Platform.isAndroid){
  //         var resId = message['extras']['cn.jpush.android.EXTRA']['res_id'];
  //
  //         // Get.toNamed(AppRoutes.calendarDetail, arguments: res_id);
  //
  //       }else{
  //
  //         var resId = message['res_id'];
  //
  //         // Get.toNamed(AppRoutes.calendarDetail, arguments: res_id);
  //
  //
  //       }
  //
  //
  //       // var json = jsonDecode(message);
  //
  //       debugPrint('messageData  === ${message['res_id']}');
  //
  //
  //     },
  //     // 接收自定义消息回调方法。
  //     onReceiveMessage: (Map<String, dynamic> message) async {
  //       debugPrint("接收自定义消息回调方法 --- flutter onReceiveMessage: $message");
  //     },
  //   );
  //
  //
  //   jpush.setBadge(0);
  //   jpush.getRegistrationID().then((value)async {
  //     debugPrint('getRegistrationID  === $value');
  //
  //     await PersistentStorage().setStorage('registration_id', value);
  //
  //     // requestDataWithUpDataResgister(value);
  //   });
  //   // debugPrint('getRegistrationID=== ${await jpush.getRegistrationID()}');
  //
  //
  //
  //   // WbcManager().init();
  // }


  bool isLogin = false;
  @override
  void initState() {
    // TODO: implement initState
    // connect();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 1 设置localizationsDelegates
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // 2 设置 supportedLocales 表示支持的国际化语言
      supportedLocales: const [
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'), //
        Locale.fromSubtags(languageCode: 'en'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'yoga',
      // theme:appThemeData,
      theme: appThemeData,
      builder: BotToastInit(),
      getPages: AppPages.routes,
      // initialRoute: AppRoutes.classroom,
      // initialRoute:isLogin==false?AppRoutes.login:AppRoutes.bottomMain,
      // home: isLogin==false?StudentLoginView():const Tabs(),
      home: const GuidePage(),
      navigatorObservers: [BotToastNavigatorObserver()],
      // home:Dome2(),
    );
  }
}


//判断是否有权限
checkPermission() async {
  //获取当前的权限
  var status = await Permission.location.status;
  if (status == PermissionStatus.granted) {

    debugPrint('已经授权');
    //已经授权
    // return true;
  } else {
    //未授权则发起一次申请
    debugPrint('未授权则发起一次申请');
    status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      // return true;
    } else {
      // return false;
    }
  }
  Permission permission = Permission.locationAlways;
  // PermissionStatus status = await permission.status;
  requestPermission(permission);

  debugPrint('检测权限$status');
  if (status.isGranted) {

    //权限通过
  } else if (status.isDenied) {
    //权限拒绝， 需要区分IOS和Android，二者不一样
    requestPermission(permission);
  } else if (status.isPermanentlyDenied) {
    //权限永久拒绝，且不在提示，需要进入设置界面
    // openAppSettings();
  } else if (status.isRestricted) {
    //活动限制（例如，设置了家长///控件，仅在iOS以上受支持。
    // openAppSettings();
  } else {
    //第一次申请
    requestPermission(permission);
  }
}

//申请权限
requestPermission(Permission permission) async {
  //多个权限申请
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    // Permission.location,
    Permission.storage,
    Permission.mediaLibrary,
    Permission.microphone,
  ].request();
  debugPrint('权限状态$statuses');
  // if (!status.isGranted) {
  //   openAppSettings();
  // }
}
