import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import '../../common/colors.dart';
import '../../components/custom_footer.dart';
import '../../services/address.dart';
import '../../services/dio_manager.dart';
import '../classroom_modules/classroom_model.dart';

class AppointmentRecordPage extends StatefulWidget {
  const AppointmentRecordPage({Key? key}) : super(key: key);

  @override
  State<AppointmentRecordPage> createState() => _AppointmentRecordPageState();
}

class _AppointmentRecordPageState extends State<AppointmentRecordPage> {


  int selectIndex = 1;

  String startDay = '';

  EasyRefreshController easyRefreshController = EasyRefreshController();

  List dataArr = [];

  requestDataWithCourseList({String? startDay,int page = 1})async{
    var params = {
      'method':'course.list',
      'page':page,
      'subscribe':'1',
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

      }
    }
    setState(() {

    });
  }

  /// 取消预约

  requestDataWithCancel(String courseTimeId)async{
    var params = {
      'method':'subscribe.cancel',
      'course_time_id':courseTimeId,
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    if(json['code'] == 200){
      BotToast.showText(text: '取消成功');
    }else{
      BotToast.showText(text: json['message']);
    }
    requestDataWithCourseList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDataWithCourseList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: _headerSliverBuilder,
        body: buildSliverBody(context),
      ),

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
      expandedHeight: 210,
      elevation: 0,
      // backgroundColor:AppColor.themeColor,
      snap: false,
      iconTheme: const IconThemeData(
          color: Colors.black
      ),
      flexibleSpace: FlexibleSpaceBar(
        title:  Text('', style: TextStyle(
          color: AppColor.themeTextColor,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),) ,
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
            alignment: Alignment.topCenter,
            // color: Colors.red,
            child: Image.asset('images/ic_bg.png',width: Get.width,fit: BoxFit.cover,),
          ),
        ),

        // Image.asset('images/appbar_bg.png',fit: BoxFit.fitWidth,width: Get.width,),
        Align(

          child:Container(
            width: Get.width,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+25),
            // height: 200,
            // color: Colors.redAccent,
            // color: Colors.redAccent,
            child: Column(
              children: [
                Image.asset('images/login_log.png',width: 130,height: 130,),
                const SizedBox(height: 3,),
                Text('預約記錄',style: TextStyle(color: AppColor.themeTextColor,fontSize: 21,
                    fontWeight: FontWeight.w700),),
              ],
            ),
          ),
        ),



        // Container(
        //   margin: EdgeInsets.only(top: 100),
        //   child: Center(
        //     child: Text('預約課堂',style: TextStyle(fontSize: 22,color: AppColor.themeTextColor,
        //         fontWeight: FontWeight.w700
        //     ),),
        //   ),
        // ),

      ],
    );
  }

  Widget buildSliverBody(BuildContext context){
    return Container(
      color: AppColor.bgColor,
      child: Column(
        children: [
          Container(
            height: 0.5,
            width: Get.width,
            color: Colors.black,
          ),
          // Container(
          //   height: 60,
          //   color: Colors.white,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       GestureDetector(
          //         onTap: (){
          //           setState(() {
          //             selectIndex =1;
          //           });
          //         },
          //         child: Container(
          //           alignment: Alignment.center,
          //           height: 45,
          //           width: 80,
          //           decoration: BoxDecoration(
          //               color: selectIndex ==1? AppColor.themeColor:Colors.transparent,
          //               borderRadius: const BorderRadius.all(Radius.circular(10))
          //           ),
          //           child:Text('預約',style: TextStyle(fontSize: 22,color:selectIndex==1?Colors.white:AppColor.themeTextColor,fontWeight: FontWeight.w700),),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: (){
          //           setState(() {
          //             selectIndex =2;
          //           });
          //         },
          //         child: Container(
          //           alignment: Alignment.center,
          //           height: 45,
          //           width: 80,
          //           decoration: BoxDecoration(
          //               color: selectIndex ==2? AppColor.themeColor:Colors.transparent,
          //               borderRadius: const BorderRadius.all(Radius.circular(10))
          //           ),
          //           child:Text('上課',style: TextStyle(fontSize: 22,color:selectIndex==2?Colors.white:AppColor.themeTextColor,fontWeight: FontWeight.w700),),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: (){
          //           setState(() {
          //             selectIndex =3;
          //           });
          //         },
          //         child: Container(
          //           alignment: Alignment.center,
          //           height: 45,
          //           width: 80,
          //           decoration: BoxDecoration(
          //               color: selectIndex ==3? AppColor.themeColor:Colors.transparent,
          //               borderRadius: const BorderRadius.all(Radius.circular(10))
          //           ),
          //           child:Text('缺席',style: TextStyle(fontSize: 22,color:selectIndex==3?Colors.white:AppColor.themeTextColor,fontWeight: FontWeight.w700),),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: (){
          //           setState(() {
          //             selectIndex =4;
          //           });
          //         },
          //         child: Container(
          //           alignment: Alignment.center,
          //           height: 45,
          //           width: 80,
          //           decoration: BoxDecoration(
          //               color: selectIndex ==4? AppColor.themeColor:Colors.transparent,
          //               borderRadius: const BorderRadius.all(Radius.circular(10))
          //           ),
          //           child:Text('取消',style: TextStyle(fontSize: 22,color:selectIndex==4?Colors.white:AppColor.themeTextColor,fontWeight: FontWeight.w700),),
          //         ),
          //       ),
          //       Image.asset('images/ic_classroom_right.png'),
          //
          //     ],
          //   ),
          // ),
          Expanded(child:   EasyRefresh.custom(
          emptyWidget:dataArr.isEmpty?const Center(child:Text('暫無信息')):null,
              header: MaterialHeader(),
              footer: MaterialFooter1(),
              controller: easyRefreshController,
              onRefresh: ()async{
               requestDataWithCourseList(page: 1);
              },
              onLoad: ()async{
              int page = 1;
              page++;
              requestDataWithCourseList(page: page);
              },
            slivers: [

              SliverToBoxAdapter(
                child:   Container(
                  height: 60,
                  color: AppColor.themeColor,
                  padding: const EdgeInsets.only(left: 55,right: 55),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('課程名稱',style: TextStyle(fontSize: 20,color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                      Text('狀態',style: TextStyle(fontSize: 20,color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: _mySliverChildBuilderDelegate(),
              ),
            ])),
        ],
      ),
    );
  }

  SliverChildBuilderDelegate _mySliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            ClassRoomList model = dataArr[index];
        return Container(
          // margin: const EdgeInsets.only(left: 30,right: 30,top: 0,bottom: 15),
          // height: 180,
          color: AppColor.bgColor,
          child: GestureDetector(
            onTap: (){
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black,
                        width: 0.3
                    )
                ),
                padding: const EdgeInsets.only(left: 15,right: 5),
                // height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          width: Get.width-150,
                          padding: EdgeInsets.only(top: 15),
                          child: Text('${model.name}',style: TextStyle(fontWeight: FontWeight.w700,
                              fontSize: 23,color: AppColor.themeTextColor),maxLines: 2,),
                        ),
                        Text('開始時間：${model.startDay} ${model.startTime}',style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 16,color: AppColor.themeTextColor),),
                        SizedBox(
                          width: 200,
                          child: Text('代幣：${model.gold}',style: TextStyle(fontWeight: FontWeight.w700,
                             fontSize: 16,color: AppColor.themeTextColor),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        ),
                        SizedBox(height: 15,),
                        // TextButton(onPressed: (){
                        //
                        //   if(model.subscribeId!>=1&&model.subscribeStatus==0){
                        //     Get.defaultDialog(title: '提示',middleText: '是否要取消當前課程',
                        //         buttonColor: AppColor.themeColor,
                        //         confirmTextColor: AppColor.themeTextColor,
                        //         cancelTextColor: AppColor.themeTextColor,
                        //         textCancel:'取消',textConfirm: '確定',onConfirm: (){
                        //       requestDataWithCancel('${model.courseTimeId}');
                        //       Get.back();
                        //     },onCancel: (){
                        //
                        //     });
                        //   }else{
                        //     BotToast.showText(text: '不可取消預約');
                        //   }
                        //
                        // }, child: Text('取消預約',style: TextStyle(color: AppColor.themeColor),)),

                      ],
                    ),

                 model.subscribeId==0?Container(
                      height: 45,
                      width: 90,
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.themeTextColor,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child:  const Text('未預約',style: TextStyle(color: Colors.white,fontSize: 13),),
                    ):model.subscribeId!>=1&&model.subscribeStatus==0?Container(
                   height: 45,
                   width: 90,
                   padding: const EdgeInsets.all(5),
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                     color: AppColor.themeTextColor,
                     borderRadius: const BorderRadius.all(Radius.circular(20)),
                   ),
                   child:  Text('預約待审核',style: TextStyle(color: Colors.white,fontSize: 13),)):model.subscribeStatus==1&&
                   model.subscribeId!>=1?Container(
                     height: 45,
                     width: 90,
                     padding: const EdgeInsets.all(5),
                     alignment: Alignment.center,
                     decoration: BoxDecoration(
                       color: AppColor.themeTextColor,
                       borderRadius: const BorderRadius.all(Radius.circular(20)),
                     ),
                     child:  Text('已預約',style: TextStyle(color: Colors.white,fontSize: 13),)):SizedBox(),

                  ],
                )
            ),
          ),
        );
      },
      childCount: dataArr.length,
    );
  }

}
