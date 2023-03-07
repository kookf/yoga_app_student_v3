import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yoga_student_app/common/app_theme.dart';
import 'package:yoga_student_app/common/colors.dart';
import 'package:yoga_student_app/pages/classroom_modules/classroom_model.dart';
import 'package:yoga_student_app/pages/sign_class_page.dart';
import 'package:yoga_student_app/router/app_pages.dart';

import '../../components/custom_footer.dart';
import '../payment_method_page.dart';
import '../receipt_page.dart';
import '../upload_receipt_page.dart';
import 'classroom_calendar_page.dart';
import 'classroom_controller.dart';

class ClassroomView extends GetView{

  @override
  final ClassroomController controller = Get.put(ClassroomController());

  ClassroomView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: GetBuilder<ClassroomController>(builder: (_){
        return SafeArea(child: NestedScrollView(
          controller: controller.scrollController,
          headerSliverBuilder: _headerSliverBuilder,
          body: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15,),
                    width: Get.width-100,
                    child: DatePicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      height: 90,
                      selectionColor: AppColor.registerBgColor,
                      selectedTextColor:AppColor.themeTextColor,
                      locale: "zh_HK",
                      onDateChange: (date) {
                        // New date selected
                        var timeFormat = DateFormat("yyyy-MM-dd");
                        var timeStr = timeFormat.format(date);
                        controller.requestDataWithCourseList(startDay:timeStr);
                      },
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Container(
                    height: 35,
                    width: 0.45,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 15,),
                  GestureDetector(
                    onTap: (){
                      Get.to(const ClassRoomCalendarPage());
                    },
                    child:Image.asset('images/ic_classroom_right.png'),
                  )
                ],
              ),
              Expanded(child: buildSliverBody(context)),
            ],
          ),
        ),);
      }),
    );
  }
  Widget buildSliverBody(BuildContext context){
    return Container(
      color: AppColor.bgColor,
      child: EasyRefresh.custom(
          header: MaterialHeader(),
          footer: MaterialFooter1(),
          controller: controller.easyRefreshController,
          onRefresh: ()=>controller.onRefresh(),
          onLoad: ()=>controller.onLoad(),
          emptyWidget:controller.dataArr.isEmpty?const Center(child:Text('暫無信息')):null,
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 60,
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('全部地點',style: TextStyle(color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                    Container(
                      height: 25,
                      width: 0.5,
                      color: Colors.black,
                    ),
                    Text('全部課程',style: TextStyle(color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                    Container(
                      height: 25,
                      width: 0.5,
                      color: Colors.black,
                    ),
                    Text('全部教練',style: TextStyle(color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),

                  ],
                ),
              ),
            ),
            SliverList(
              delegate: _mySliverChildBuilderDelegate(),
            ),
          ]),
    );
  }
    ///页面滚动头部处理
  List<Widget> _headerSliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget> [
      buildSliverAppBar(context)
    ];
  }
  ///导航部分渲染
  Widget buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: 240,
      elevation: 0,
      // backgroundColor:AppColor.themeColor,
      snap: false,
      iconTheme: const IconThemeData(
        color: Colors.black
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: controller.headerWhite ? Text('預約課堂', style: TextStyle(
            color: AppColor.themeColor,
            fontWeight: FontWeight.w500,
            fontSize: 17,
        ),) :const Text(''),
        centerTitle: true,
        background: buildAppBarBackground(context),
      ),
    );
  }

  Widget buildAppBarBackground(BuildContext context) {
    return Stack(
      children: [

        Align(
          alignment: const Alignment(0, -0.8),
          child:SizedBox(
            width: Get.width,
            // height: 200,
            // color: Colors.redAccent,
            // color: Colors.redAccent,
            child: Column(
              children: [
                Image.asset('images/login_log.png',width: 120,height: 120,),
                const SizedBox(height: 15,),
              ],
            ),
          ),
        ),

        Center(
          child: Container(
            // height: 140,
            alignment: Alignment.topCenter,
            // color: Colors.red,
            child: Image.asset('images/ic_yuyuebg.png',width: Get.width,fit: BoxFit.cover,),
          ),
        ),

        Container(
          margin: const EdgeInsets.only(top: 100),
          child: Center(
            child: Text('預約課堂',style: TextStyle(fontSize: 22,color: AppColor.themeTextColor,
                fontWeight: FontWeight.w700
            ),),
          ),
        ),

      ],
    );
  }

    _mySliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
          (BuildContext context, int index) {
        ClassRoomList model = controller.dataArr[index];

        return Container(
          margin: const EdgeInsets.only(left: 30,right: 30,top: 0,bottom: 15),
          height: 260,
          color: AppColor.bgColor,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  height: 235,
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 45,left: 15,),
                        child: Text('${model.name}',style: appThemeData.textTheme.bodyText1!.copyWith(
                            color: AppColor.themeTextColor,fontWeight: FontWeight.w700,fontSize: 22
                        ),),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15,left: 15),
                        child: Text('日期：${model.startDay}',style: appThemeData.textTheme.bodyText1!.copyWith(
                          color: AppColor.themeTextColor,fontWeight: FontWeight.w700
                        ),),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15,left: 15),

                        child: Text('導師：${model.teacherName}',style:
                        appThemeData.textTheme.bodyText1!.copyWith(
                            color: AppColor.themeTextColor,fontWeight: FontWeight.w700
                        )),
                      ),
                      SizedBox(
                        width: Get.width,
                        height: 45,
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 15,left: 15),
                              child: Text('預約人數：${model.subscribeUser}/${model.totalUser}',style:
                              appThemeData.textTheme.bodyText1!.copyWith(
                                  color: AppColor.themeTextColor,fontWeight: FontWeight.w700
                              )),
                            ),
                       model.subscribeStatus==1?Container(
                              margin: const EdgeInsets.only(right: 15,top: 5),
                              alignment: Alignment.centerLeft,
                              // color: Colors.red,
                              child: Container(
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    color: AppColor.themeColor
                                ),
                                child:  InkWell(
                                  onTap: (){
                                    // Get.toNamed(AppRoutes.classtime);
                                    Get.to(SignClassPage());
                                  },
                                  // onPressed: (){
                                  //   Get.toNamed(AppRoutes.classtime);
                                  //   Get.to(SignClassPage());
                                  // },
                                  child: const Text('已預約',style: TextStyle(color: Colors.white),),),
                              ),
                              // color: Colors.yellowAccent,
                            ):Container(
                         margin: const EdgeInsets.only(right: 15,top: 5),
                         alignment: Alignment.centerLeft,
                         // color: Colors.red,
                         child: Container(
                           width: 100,
                           alignment: Alignment.center,
                           decoration: BoxDecoration(
                               borderRadius: const BorderRadius.all(Radius.circular(20)),
                               color: AppColor.themeColor
                           ),
                           child:  InkWell(
                             onTap: (){
                               Get.toNamed(AppRoutes.classtime,arguments: model);
                               // Get.to(SignClassPage());
                               // Get.to(UpLoadReceiptPage());
                               // Get.to(PayMethodPage());
                             },
                             // onPressed: (){
                             //   Get.toNamed(AppRoutes.classtime);
                             //   Get.to(SignClassPage());
                             // },
                             child: const Text('未預約',style: TextStyle(color: Colors.white),),),
                         ),
                         // color: Colors.yellowAccent,
                       )
                          ],),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                // color: Colors.white,
                margin: const EdgeInsets.only(top: 5,left: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('images/header.png',width: 55,height: 55,),
                    Container(
                      margin: const EdgeInsets.only(top: 15,right: 15),
                      child: Text('時間：${model.startTime} - ${model.endTime}',
                        style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,
                            color: AppColor.themeTextColor),),
                    )
                  ],
                )
              )
            ],
          ),
        );
      },
      childCount: controller.dataArr.length,
    );
  }

}