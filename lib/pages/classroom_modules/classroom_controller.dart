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
import 'course_cate_model.dart';
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

  List <String>teacherNameArr = ['全部教練'];

  DateTime initDatetime = DateTime.now();

  int page = 1;

  String startDay = '';
  int teacherId = 0;
  int cateId = 0;

  requestDataWithCourseList({int page =1,})async{
    var params = {
      'method':'course.list',
      'page':page,
      'subscribe':'0',
      'start_day':startDay,
      'is_teacher':'0',
      'teacher_id':teacherId,
       'cate_id':cateId,
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

  String selectedValue = '全部教練';
  String selectedCourseValue = '所有程度';

  TeacherListModel? teacherListModel;
  requestDataWithTeacher()async{
    var params = {
      'method':'course.teacher_list',
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams:params);

    TeacherListModel model = TeacherListModel.fromJson(json);
    teacherListModel = model;
    // teacherNameArr.insert(0, '全部教練-0');

    for(int i = 0;i<model.data!.list!.length;i++){
      teacherNameArr.add('${model.data!.list![i].teacherName!}');
    }

    // dataArr.add(model.data!.list!);

    update();

  }

  List <String>courseNameArr = ['所有程度'];

  // CourseListModel? courseListModel;
  //
  // requestDataWithCourseName()async{
  //   var params = {
  //     'method':'course.name',
  //   };
  //   var json = await DioManager().kkRequest(Address.hostAuth,bodyParams:params);
  //
  //   CourseListModel model = CourseListModel.fromJson(json);
  //   courseListModel = model;
  //   for(int i = 0;i<model.data!.list!.length;i++){
  //     courseNameArr.add('${model.data!.list![i].courseName!}');
  //   }
  //   update();
  // }
  /// 获取课堂程度分类
  CourseCateModel? courseCateModel;
  requestDataWithCourseCate()async{
    var params = {
      'method':'course.cate',
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    CourseCateModel model = CourseCateModel.fromJson(json);
    for(int i = 0;i<model.data!.list!.length;i++){
      courseNameArr.add('${model.data!.list![i].cateName!}');
    }
    courseCateModel = model;
    update();
  }

  /// 下拉刷新
  onRefresh()async{
     page = 1 ;
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
    if(value == '全部教練'){
      teacherId = 0;
      startDay = '';
      requestDataWithCourseList();
      update();
    }else{
      for(int i = 0;i<teacherListModel!.data!.list!.length;i++){
        if(value == teacherListModel!.data!.list![i].teacherName){
          teacherId = teacherListModel!.data!.list![i].teacherId!;
        }
      }
      startDay = '';
      requestDataWithCourseList();
    }

    update();
  }

  /// 課堂篩選
  filterCourse(String value){
    selectedCourseValue = value;
    if(value == '所有程度'){
      cateId = 0;
      startDay = '';
      requestDataWithCourseList();
    }else{

      for(int i = 0;i<courseCateModel!.data!.list!.length;i++){
        if(value == courseCateModel!.data!.list![i].cateName){
          cateId = courseCateModel!.data!.list![i].cateId!;
        }
      }

      startDay = '';
      requestDataWithCourseList();
    }
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
    requestDataWithCourseCate();
    // requestDataWithCourseName();
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