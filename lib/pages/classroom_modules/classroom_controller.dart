import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yoga_student_app/pages/classroom_modules/classroom_model.dart';
import 'package:yoga_student_app/pages/classroom_modules/tearcher_list_model.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';

import '../../common/eventbus.dart';
import 'classroom_calendar_page.dart';
import 'course_list_model.dart';

class ClassroomController extends GetxController{


  ///
  String teacherName = '全部教練';
  ///滚动监听设置
  ScrollController scrollController = ScrollController();
  ///头部背景布局 true滚动一定的高度 false 滚动高度为0
  bool headerWhite = false;

  /// 默认选第一个
  ///
  int selectionTab = 1;

  // var page = 1;


  EasyRefreshController easyRefreshController = EasyRefreshController();

  List dataArr = [];

  List <String>teacherNameArr = ['全部教練-0'];
  List <int>teacherIdArr = [];

  DateTime initDatetime = DateTime.now();

  int page = 1;

  String startDay = '';
  int teacherId = 0;
  int courseId = 0;

  requestDataWithCourseList({int page =1,})async{
    var params = {
      'method':'course.list',
      'page':page,
      'subscribe':'0',
      'start_day':startDay,
      'is_teacher':'0',
      'teacher_id':teacherId,
       'course_id':courseId,
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

      }
    }
    update();
  }

  String selectedValue = '全部教練-0';
  String selectedCourseValue = '所有課堂-0';

  requestDataWithTeacher()async{
    var params = {
      'method':'course.teacher_list',
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams:params);

    TeacherListModel model = TeacherListModel.fromJson(json);

    // teacherNameArr.insert(0, '全部教練-0');
    teacherIdArr.insert(0, 00);
    
    for(int i = 0;i<model.data!.list!.length;i++){
      teacherNameArr.add('${model.data!.list![i].teacherName!}-${i+1}');
      teacherIdArr.add(model.data!.list![i].teacherId!);
    }

    // dataArr.add(model.data!.list!);

    update();

  }

  List <String>courseNameArr = ['所有課堂-0'];
  List <int>courseIdArr = [];

  requestDataWithCourseName()async{
    var params = {
      'method':'course.name',
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams:params);

    CourseListModel model = CourseListModel.fromJson(json);

    // teacherNameArr.insert(0, '全部教練-0');
    courseIdArr.insert(0, 00);

    for(int i = 0;i<model.data!.list!.length;i++){
      courseNameArr.add('${model.data!.list![i].courseName!}-${i+1}');
      courseIdArr.add(model.data!.list![i].courseId!);
    }

    // dataArr.add(model.data!.list!);

    update();

  }
  /// 下拉刷新
  onRefresh()async{

    var data = selectedValue.split('-')[1];
     page = 1 ;
     teacherId = teacherIdArr[int.parse(data)];
    requestDataWithCourseList(page: page,);
  }
  /// 上拉加載
  onLoad()async{
    page++;
    requestDataWithCourseList(page: page);
  }

  ///老師篩選
  filterTeacher(String value){
    selectedValue = value;
    var data = value.split('-')[1];
    teacherId = teacherIdArr[int.parse(data)];
    requestDataWithCourseList();
    update();
  }

  jumpToCalendar()async{
    var data = await Get.to(const ClassRoomCalendarPage());
    if(data!=null){
      initDatetime = DateTime.parse(data);
      startDay = data;
      print(initDatetime);
      print(DateTime.now());
      dataArr.clear();
      requestDataWithCourseList(page: 1,);
    }
    update();
  }


  var eventBusFn;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestDataWithTeacher();
    requestDataWithCourseName();
    // scrollController.addListener(() {
    //   ///监听滚动位置设置导航栏颜色
    //     headerWhite = scrollController.offset == 350 ? true : false;
    //     print(scrollController.offset);
    //     print(headerWhite);
    //     update();
    // });

    // var nowDateTime = DateTime.now();
    // var timeFormat = DateFormat("yyyy-MM-dd");
    // var timeStr = timeFormat.format(nowDateTime);
    // startDay = timeStr;

    requestDataWithCourseList();

    eventBusFn = eventBus.on<EventFn>().listen((event) {
      //  event为 event.obj 即为 eventBus.dart 文件中定义的 EventFn 类中监听的数据

      if(event.obj == 'refresh'){
        requestDataWithCourseList();
      }
      print('event.obj hh ===== ${event.obj}');
    });

  }

}