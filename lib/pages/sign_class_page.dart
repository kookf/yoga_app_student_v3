import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yoga_student_app/common/colors.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';
import 'package:yoga_student_app/utils/persistent_storage.dart';

import '../components/counter_down_page.dart';
import '../components/slide_widget.dart';
import 'package:get/get.dart';
class SignClassPage extends StatefulWidget {


  int? courseTimeId;

  String? teacherName;

  SignClassPage({super.key, this.courseTimeId,this.teacherName});

  @override
  State<SignClassPage> createState() => _SignClassPageState();
}

class _SignClassPageState extends State<SignClassPage> {




  int? countTime;

  requestDataWithCourseInfo()async{
    var params = {
      'method':'course.info',
      'course_time_id':'${widget.courseTimeId}',
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    var date = DateTime.now();

    String startDay = json['data']['start_day'];
    String startTime = json['data']['start_time'];
    String endTime = json['data']['end_time'];
    var startDate = DateTime.parse('$startDay $startTime');
    // var endDate = DateTime.parse('$startDay $endTime');
    countTime = startDate.difference(date).inSeconds;
    print('${startDate} ${date}======${startDate.difference(date).inSeconds}');

    setState(() {

    });
  }

  /// 簽到
  requestDataWithSignChange(var signInAt)async{
    var params = {
      'method':'sign.in',
      // 'user_id':await PersistentStorage().getStorage('id'),
      // 'sign_in_at':signInAt,
      'course_time_id':'${widget.courseTimeId}',
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    if(json['code'] == 200){
      BotToast.showText(text: '簽到成功');
    }else{
      BotToast.showText(text: json['data']);

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDataWithCourseInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColor.themeColor,
      //   title: Text('上課簽到',style: TextStyle(color: AppColor.themeTextColor,fontSize: 18),),
      // ),
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).padding.top+kToolbarHeight,
              width: Get.width,
              decoration: const BoxDecoration(
                image:DecorationImage(image: AssetImage('images/appbar_bg.png',),
                  fit: BoxFit.fill,
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 35),
                    child:IconButton(onPressed: (){
                      Get.back();
                    }, icon: const Icon(Icons.arrow_back_ios),color: Colors.white,),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 35),
                    child: const Text('上課簽到',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                  ),
                ],
              )
          ),
          Expanded(child: ListView(
            children: [
              SizedBox(height: 15,),
             Center(
               child:  Container(
                 width: 110,
                 height: 110,
                 decoration: BoxDecoration(
                     color: AppColor.themeColor,
                     borderRadius: const BorderRadius.all(Radius.circular(60))
                 ),
                 child:Image.asset('images/login_log.png'),
               ),
             ),
              const SizedBox(height: 25,),
              Center(child:Text('${widget.teacherName}的課堂',style: TextStyle(color: AppColor.themeTextColor,fontSize: 24),),),
              const SizedBox(height: 5,),
              Center(
                child:Text('距離上課時間還剩',style: TextStyle(color: AppColor.themeTextColor,fontSize: 18),),
              ),
              const SizedBox(height: 5,),
              CounterDownPage(countTime!),
              Center(
                child: SlideVerifyWidget(
                  height: 60,
                  backgroundColor: AppColor.themeColor,
                  borderColor: AppColor.themeColor,
                  verifySuccessListener: (){
                    var date = DateTime.now();
                    var timeFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
                    var timeStr = timeFormat.format(date);

                    // print(timeStr);
                    requestDataWithSignChange(timeStr);
                  },
                ),
              )
            ],
          ),)
        ],
      )
    );
  }
}
