import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yoga_student_app/common/app_theme.dart';
import 'package:yoga_student_app/common/colors.dart';
import 'package:yoga_student_app/lang/message.dart';
import 'package:yoga_student_app/pages/classroom_modules/classroom_model.dart';
import 'package:yoga_student_app/pages/sign_class_page.dart';
import 'package:yoga_student_app/router/app_pages.dart';
import '../../components/custom_footer.dart';
import '../../services/address.dart';
import '../mine_modules/privacy_page.dart';
import 'classroom_controller.dart';

class ClassroomView extends GetView {
  @override
  final ClassroomController controller = Get.put(ClassroomController());

  ClassroomView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<ClassroomController>(builder: (_) {
        return Column(
          children: [
            Expanded(child:  EasyRefresh.custom(
              header: MaterialHeader(),
              footer: MaterialFooter1(),
              controller: controller.easyRefreshController,
              onRefresh: () => controller.onRefresh(),
              onLoad: () => controller.onLoad(),
              // emptyWidget:controller.dataArr.isEmpty?const Center(child:Text('暫無課程')):null,
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 150,
                    // color: Colors.yellowAccent,
                    child: buildAppBarBackground(context),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 45,
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomDropdownButton2(
                          // dropdownWidth: Get.width-50,
                          buttonWidth: 150,
                          hint: '',
                          dropdownItems: controller.teacherNameArr,
                          value: controller.selectedValue,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 25,
                          ),
                          buttonDecoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          onChanged: (value) {
                            controller.filterTeacher(value!);
                          },
                        ),
                        // Text('全部地點',style: TextStyle(color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                        // Container(
                        //   height: 25,
                        //   width: 0.5,
                        //   color: Colors.black,
                        // ),
                        //   Text('全部課程',style: TextStyle(color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                        Container(
                          height: 25,
                          width: 0.5,
                          color: Colors.black,
                        ),
                        CustomDropdownButton2(
                          // dropdownWidth: Get.width-50,
                          buttonWidth: 150,
                          hint: '',
                          dropdownItems: controller.courseNameArr,
                          value: controller.selectedCourseValue,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 25,
                          ),
                          buttonDecoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          onChanged: (value) {
                            controller.filterCourse(value!);
                          },
                        ),
                        // GestureDetector(
                        //   onTap: ()async{
                        //    controller.jumpToTeacherList();
                        //   },
                        //   child:Text(controller.teacherName,style: TextStyle(color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                        // )
                      ],
                    ),
                  ),
                ),
                _buildStickBox(), // tag1
                controller.dataArr.isEmpty
                    ? SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    alignment: const Alignment(0, 0.1),
                    child: const Text(I18nContent.noRecords),
                  ),
                )
                    : SliverList(
                  delegate: _mySliverChildBuilderDelegate(),
                ),
              ],
            ),),
            Container(height: 55,
              child: Center(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(value: controller.check, onChanged: (value){
                      controller.check =! controller.check;
                      controller.update();
                    },checkColor: Colors.white,activeColor: AppColor.themeColor,),
                    Text.rich(
                      TextSpan(
                          text: '',
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()..onTap =(){
                                  Get.to(PrivacyPage());
                                },
                                text: ' 隱私政策',
                                style: TextStyle(color: AppColor.themeTextColor,fontStyle: FontStyle.normal)
                            )
                          ]
                      ),

                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildSliverBody(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      child: EasyRefresh.custom(
          header: MaterialHeader(),
          footer: MaterialFooter1(),
          controller: controller.easyRefreshController,
          onRefresh: () => controller.onRefresh(),
          onLoad: () => controller.onLoad(),
          emptyWidget: controller.dataArr.isEmpty
              ? const Center(child: Text('暫無課程'))
              : null,
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '全部地點',
                      style: TextStyle(
                          color: AppColor.themeTextColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 25,
                      width: 0.5,
                      color: Colors.black,
                    ),
                    Text(
                      '全部課程',
                      style: TextStyle(
                          color: AppColor.themeTextColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 25,
                      width: 0.5,
                      color: Colors.black,
                    ),
                    Text(
                      '全部教練',
                      style: TextStyle(
                          color: AppColor.themeTextColor,
                          fontWeight: FontWeight.w600),
                    ),
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

  ///导航部分渲染
  Widget buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      elevation: 0,
      snap: false,
      iconTheme: const IconThemeData(color: Colors.black),
      flexibleSpace: FlexibleSpaceBar(
        title: controller.headerWhite
            ? Text(
                '預約課堂',
                style: TextStyle(
                  color: AppColor.themeColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              )
            : const Text(''),
        centerTitle: true,
        background: buildAppBarBackground(context),
      ),
    );
  }

  Widget buildAppBarBackground(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            // height: 140,
            alignment: Alignment.center,
            // color: Colors.red,
            child: Image.asset(
              'images/ic_yuyuebg.png',
              width: Get.width,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          child: SizedBox(
            width: Get.width,
            // height: 200,
            // color: Colors.redAccent,
            // color: Colors.redAccent,
            child: Column(
              children: [
                Image.asset(
                  'images/login_log.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 100),
          child: Center(
            child: Text(
              '預約課堂',
              style: TextStyle(
                  fontSize: 22,
                  color: AppColor.themeTextColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }

  _mySliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        ///
        // ClassRoomList model = controller.dataArr[index];
        Classroomlist model = controller.dataArr[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 25, right: 15, top: 10),
              color: Colors.transparent,
              child: Text(
                '${model.day}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColor.smallTextColor),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, a) {
                return GestureDetector(
                  onTap: () async {
                    var data = await Get.toNamed(AppRoutes.classtime,
                        arguments: model.course![a]);
                    if (data == 'refresh') {
                      controller.requestDataWithCourseList();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 0, bottom: 15),
                    height: 270,
                    color: AppColor.bgColor,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            height: 240,
                            width: Get.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 35, left: 15, right: 15),
                                  child: Text(
                                    '${model.course?[a].name}',
                                    style: appThemeData.textTheme.bodyText1!
                                        .copyWith(
                                      color: AppColor.themeTextColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 15),
                                  child: Text(
                                    '開堂時間：${model.course?[a].startDay} ${model.course?[a].startTime}',
                                    style: appThemeData.textTheme.bodyText1!
                                        .copyWith(
                                            color: AppColor.themeTextColor,
                                            fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 15),
                                  child: Text(
                                    '是否簽到：${model.course?[a].signIn == 1 ? '已簽到' : '未簽到'}',
                                    style: appThemeData.textTheme.bodyText1!
                                        .copyWith(
                                            color: AppColor.themeTextColor,
                                            fontWeight: FontWeight.w700),
                                  ),
                                ),
                                // Container(
                                //   margin: const EdgeInsets.only(top: 10,left: 15),
                                //
                                //   child: Text('地址：${model.address}',style:
                                //   appThemeData.textTheme.bodyText1!.copyWith(
                                //       color: AppColor.themeTextColor,fontWeight: FontWeight.w700,
                                //   ),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                // ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 15),
                                  child: Text(
                                      '導師：${model.course?[a].teacherName}',
                                      style: appThemeData.textTheme.bodyText1!
                                          .copyWith(
                                              color: AppColor.themeTextColor,
                                              fontWeight: FontWeight.w700)),
                                ),
                                SizedBox(
                                  width: Get.width,
                                  height: 45,
                                  // color: Colors.red,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, left: 15),
                                        child: Text(
                                            '預約人數：${model.course?[a].subscribeUser}/${model.course?[a].totalUser}',
                                            style: appThemeData
                                                .textTheme.bodyText1!
                                                .copyWith(
                                                    color:
                                                        AppColor.themeTextColor,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                      ),
                                      model.course?[a].subscribeStatus == 1 &&
                                              model.course![a].subscribeId! >= 1
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10, top: 5),
                                              alignment: Alignment.centerLeft,
                                              // color: Colors.red,
                                              child: Container(
                                                width: 100,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    color: AppColor.themeColor),
                                                child: InkWell(
                                                  onTap: () {
                                                    // Get.to(SignClassPage(courseTimeId: model.courseTimeId,teacherName: model.teacherName,));
                                                  },
                                                  child: const Text(
                                                    '已預約',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              // color: Colors.yellowAccent,
                                            )
                                          : model.course?[a].subscribeId == 0
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10, top: 5),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  // color: Colors.red,
                                                  child: Container(
                                                    width: 100,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    20)),
                                                        color: AppColor
                                                            .themeColor),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        // var data = await Get.toNamed(
                                                        //     AppRoutes.classtime,
                                                        //     arguments: model);
                                                        // if (data == 'refresh') {
                                                        //   controller
                                                        //       .requestDataWithCourseList();
                                                        // }
                                                        var data =
                                                            await Get.toNamed(
                                                                AppRoutes
                                                                    .classtime,
                                                                arguments: model
                                                                    .course![a]);
                                                        if (data == 'refresh') {
                                                          controller
                                                              .requestDataWithCourseList();
                                                        }
                                                      },
                                                      child: const Text(
                                                        '未預約',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  // color: Colors.yellowAccent,
                                                )
                                              : model.course![a].subscribeId! >=
                                                          1 &&
                                                      model.course?[a]
                                                              .subscribeStatus ==
                                                          0
                                                  ? Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 15,
                                                              top: 5),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      // color: Colors.red,
                                                      child: Container(
                                                        width: 100,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius
                                                                        .circular(
                                                                            20)),
                                                            color: AppColor
                                                                .themeColor),
                                                        child: InkWell(
                                                          onTap: () {
                                                            BotToast.showText(
                                                                text:
                                                                    '已預約,等待審核');
                                                            // Get.toNamed(AppRoutes.classtime,arguments: model);
                                                          },
                                                          child: const Text(
                                                            '預約待审核',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                      // color: Colors.yellowAccent,
                                                    )
                                                  : const SizedBox(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                            // color: Colors.white,
                            margin: const EdgeInsets.only(top: 5, left: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                  ),
                                  width: 50,
                                  height: 50,
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${Address.homeHost}/storage/${model.course?[a].teacherAvatar}',
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Image.asset(
                                //   'images/header.png',
                                //   width: 55,
                                //   height: 55,
                                // ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 35, right: 15),
                                  child: Text(
                                    // '時間：${model.startTime} - ${model.endTime}',
                                    '時間：${model.course?[a].times}分鐘',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: AppColor.themeTextColor),
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                );
              },
              itemCount: model.course?.length ?? 0,
            )
          ],
        );
      },
      childCount: controller.dataArr.length,
    );
  }

  Widget _buildStickBox() {
    return SliverPersistentHeader(
      pinned: true,
      delegate:
          FixedPersistentHeaderDelegate(height: 55, controller: controller),
    );
  }
}

class FixedPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  ClassroomController controller;

  FixedPersistentHeaderDelegate(
      {required this.height, required this.controller});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GetBuilder<ClassroomController>(builder: (_) {
      return Container(
        padding: EdgeInsets.only(left: 10, right: 3),
        height: height,
        // alignment: Alignment.center,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${controller.startDay.substring(5)} ~'
              ' ${controller.endDay.substring(5)}',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColor.themeTextColor),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 0,
              ),
              // width: Get.width - 100,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        controller.backWeek();
                        controller.update();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 15,
                        color: AppColor.themeTextColor,
                      )),
                  GestureDetector(
                    onTap: () {
                      controller.getInitWeek();
                      controller.requestDataWithCourseList();
                      controller.update();
                    },
                    child: Text(
                      'This Week',
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: AppColor.themeTextColor),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        controller.nextWeek();
                        controller.update();
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: AppColor.themeTextColor,
                      )),
                ],
              ),

              // child: DatePicker(
              //   DateTime.now(),
              //   // initialSelectedDate:controller.initDatetime,
              //   height: 90,
              //   selectionColor: AppColor.registerBgColor,
              //   selectedTextColor: AppColor.themeTextColor,
              //   locale: "zh_HK",
              //   onDateChange: (date) {
              //     // New date selected
              //     var timeFormat = DateFormat("yyyy-MM-dd");
              //     var timeStr = timeFormat.format(date);
              //     controller.startDay = timeStr;
              //     controller.requestDataWithCourseList();
              //   },
              // ),
            ),
            const SizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: () async {
                controller.jumpToCalendar();
              },
              child: Image.asset(
                'images/ic_classroom_right.png',
                width: 45,
                height: 45,
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant FixedPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.height != height;
  }
}
