import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yoga_student_app/pages/classroom_modules/classroom_model.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';

import '../../common/eventbus.dart';
import 'classroom_calendar_page.dart';

class ClassroomController extends GetxController{

  ///滚动监听设置
  ScrollController scrollController = ScrollController();
  ///头部背景布局 true滚动一定的高度 false 滚动高度为0
  bool headerWhite = false;

  /// 默认选第一个
  ///
  int selectionTab = 1;

  // var page = 1;

  String startDay = '';

  EasyRefreshController easyRefreshController = EasyRefreshController();

  List dataArr = [];

  DateTime initDatetime = DateTime.now();


  requestDataWithCourseList({String? startDay,int page = 1})async{
    var params = {
      'method':'course.list',
      'page':page,
      'subscribe':'0',
      'start_day':startDay,
      'is_teacher':'0',
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    ClassRoomModel model = ClassRoomModel.fromJson(json);
    // dataArr.clear();
    if(page == 1){
      easyRefreshController.resetLoadState();
      dataArr.clear();
      dataArr.addAll(model.data!.list!);
    }else{
      if(model.data!.list!.isNotEmpty){
        dataArr.addAll(model.data!.list!);
      }else{
        easyRefreshController.finishLoad(noMore: true);
        BotToast.showText(text: '暂无更多');
      }
    }
    update();
  }
  onRefresh()async{
    int page = 1 ;
    requestDataWithCourseList(page: page,startDay: startDay);
  }
  onLoad()async{
    int page = 1;
    page++;
    requestDataWithCourseList(startDay:startDay,page: page);
  }

  jumpToCalendar()async{
    var data = await Get.to(const ClassRoomCalendarPage());
    if(data!=null){
      initDatetime = DateTime.parse(data);
      print(initDatetime);
      print(DateTime.now());
      dataArr.clear();
      requestDataWithCourseList(startDay: data,page: 1);
    }
    update();
  }


  var eventBusFn;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController.addListener(() {
      ///监听滚动位置设置导航栏颜色
        headerWhite = scrollController.offset == 350 ? true : false;
        print(scrollController.offset);
        print(headerWhite);
        update();
    });
    var nowDateTime = DateTime.now();
    var timeFormat = DateFormat("yyyy-MM-dd");
    var timeStr = timeFormat.format(nowDateTime);
    startDay = timeStr;
    requestDataWithCourseList(startDay:startDay);

    eventBusFn = eventBus.on<EventFn>().listen((event) {
      //  event为 event.obj 即为 eventBus.dart 文件中定义的 EventFn 类中监听的数据

      if(event.obj == 'refresh'){
        requestDataWithCourseList(startDay:startDay);
      }
      print('event.obj hh ===== ${event.obj}');
    });

    // dataArr.add(0);
    // dataArr.add(0);
    // dataArr.add(0);
  }

}