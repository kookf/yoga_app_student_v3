import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/pages/classroom_modules/classroom_view.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';

import '../common/colors.dart';
import 'mine_modules/appointment_record_page.dart';
import 'mine_modules/purchase_history_page.dart';
class ReserveListPage extends StatefulWidget {
  const ReserveListPage({Key? key}) : super(key: key);

  @override
  State<ReserveListPage> createState() => _ReserveListPageState();
}

class _ReserveListPageState extends State<ReserveListPage> {

  requestDataWithSubscribeList()async{
    var params = {
      'method':'subscribe.list',
      'course_time_id':'',
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams:params);

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDataWithSubscribeList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: Get.width,
            // color: Colors.red,
            margin: const EdgeInsets.only(top: 25),
            height: 300,
            child: Stack(
              children: [
                SizedBox(
                  width: Get.width,
                  child: Image.asset('images/ic_bg.png',fit: BoxFit.fill,),
                ),
                Align(alignment: const Alignment(0, -0.5),child:  Image.asset('images/login_log.png',width: 150,height: 150,),),

                Align(
                  child: Container(
                    margin: const EdgeInsets.only(top: 150),
                    child: Text('預約課堂',style: TextStyle(fontSize: 25,
                        fontWeight: FontWeight.w700,color: AppColor.themeTextColor),),
                  ),
                ),

              ],
            ),

          ),

          GestureDetector(
            onTap: (){
              Get.to(ClassroomView());
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black,
                        width: 0.3
                    )
                ),
                padding: const EdgeInsets.only(left: 55,right: 55),
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('時間表',style: TextStyle(fontWeight: FontWeight.w700,
                        fontSize: 23,color: AppColor.themeTextColor),),
                    const Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                )
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.to(const AppointmentRecordPage());
            },
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(left: 55,right: 55),
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('預約記錄',style: TextStyle(fontWeight: FontWeight.w700,
                        fontSize: 23,color: AppColor.themeTextColor),),
                    const Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                )
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.to(const PurchaseHistoryPage());
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black,
                        width: 0.3
                    )
                ),
                padding: const EdgeInsets.only(left: 55,right: 55),
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('購買記錄',style: TextStyle(fontWeight: FontWeight.w700,
                        fontSize: 23,color: AppColor.themeTextColor),),
                    const Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                )
            ),
          ),

        ],
      ),
    );
  }
}
