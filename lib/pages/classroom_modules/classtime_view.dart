import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/common/colors.dart';
import '../../services/address.dart';
import 'classtime_controller.dart';



class ClassTimeView extends GetView{

  @override
  final ClassTimeController controller = Get.put(ClassTimeController());


  final List<String> items = [
    '課程1',
    '課程2',
    '課程3',
    '課程4',
    '課程5',
    '課程6',
    '課程7',
    '課程8',
  ];
  final List<String> type = [
    '個人錢包',
    '共享錢包',
  ];

  String? selectedValue;
  String? dataSelectedValue;
  String? timeSelectedValue;
  String? typeSelectedValue;
  ClassTimeView({super.key});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // backgroundColor: AppColor.bgColor,
      // appBar: AppBar(
      //   backgroundColor: AppColor.themeColor,
      // ),
      body: GetBuilder<ClassTimeController>(builder: (_){
        return Column(
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
                      child: const Text('預約課堂',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                    ),
                  ],
                )
            ),
            Center(child: Text('',style: TextStyle(fontSize: 30,color: AppColor.themeTextColor,fontWeight: FontWeight.w700),)),
            const SizedBox(height: 15,),

            Center(
              child: Container(
                // height: 100,
                // width: 100,
                // color: Colors.red,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      width: 100,
                      height: 100,
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        imageUrl:
                        '${Address.homeHost}/storage/${controller.model?.teacherAvatar}',
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text('${controller.model?.teacherName}',style: TextStyle(
                      fontSize: 18,color: Colors.black,
                    ),)
                  ],
                )
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  //设置四周圆角 角度
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  //设置四周边框
                  border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                ),
                width: Get.width -50,
                padding: const EdgeInsets.only(left: 5),
                height: 40,
                alignment: Alignment.centerLeft,
                child:Text('課堂名稱:${controller.model!.name}')
                // CustomDropdownButton2(
                //   dropdownWidth: Get.width-50,
                //   hint: '請選擇課程',
                //   dropdownItems: items,
                //   value: controller.model!.name,
                //   buttonDecoration: const BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(8))
                //   ),
                //   onChanged: (value) {
                //     // selectedValue = value;
                //     // controller.update();
                //   },
                // ),
              ),
            ),

            const SizedBox(height: 15,),
            Center(
              child: Container(
                height:40,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.only(left: 5),
                width: Get.width-50,
                //边框设置
                decoration:  BoxDecoration(
                  color: Colors.white,
                  //设置四周圆角 角度
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  //设置四周边框
                  border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                ),
                child: Row(
                  children: [
                    const Text('課程學生:',),
                    Text('${controller.userName}',)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Center(
              child:  Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                  ),
                  width: Get.width -50,
                  padding: const EdgeInsets.only(left: 5),
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child:Text('開堂日期:${controller.model!.startDay}')
                // CustomDropdownButton2(
                //   dropdownWidth: Get.width-50,
                //   hint: '請選擇課程',
                //   dropdownItems: items,
                //   value: controller.model!.name,
                //   buttonDecoration: const BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(8))
                //   ),
                //   onChanged: (value) {
                //     // selectedValue = value;
                //     // controller.update();
                //   },
                // ),
              ),
            ),

            // GestureDetector(
            //   onTap: (){
            //     Get.to( ClassRoomCalendarPage());
            //   },
            //   child: Center(
            //     child: Container(
            //       height:40,
            //       margin: const EdgeInsets.only(top: 5),
            //       padding: const EdgeInsets.only(left: 15),
            //       width: Get.width-50,
            //       //边框设置
            //       decoration:  BoxDecoration(
            //         color: Colors.white,
            //         //设置四周圆角 角度
            //         borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            //         //设置四周边框
            //         border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
            //       ),
            //       child: Row(
            //         children: [
            //           Text('課程日期:',style: TextStyle(color: AppColor.registerBgColor),),
            //           Text('2023-01-29',style: TextStyle(color: AppColor.themeTextColor),)
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Image.asset('images/classtime_bg.png',width: Get.width,),
            const SizedBox(height: 15,),
            // GestureDetector(
            //   onTap: (){
            //     Get.to( ClassRoomCalendarPage());
            //   },
            //   child: Center(
            //     child: Container(
            //       height:40,
            //       margin: const EdgeInsets.only(top: 5),
            //       padding: const EdgeInsets.only(left: 15),
            //       width: Get.width-50,
            //       //边框设置
            //       decoration:  BoxDecoration(
            //         color: Colors.white,
            //         //设置四周圆角 角度
            //         borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            //         //设置四周边框
            //         border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
            //       ),
            //       child: Row(
            //         children: [
            //           Text('課程時間:',style: TextStyle(color: AppColor.registerBgColor),),
            //           Text('2023-01-29',style: TextStyle(color: AppColor.themeTextColor),)
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Center(
              child:  Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                  ),
                  width: Get.width -50,
                  padding: const EdgeInsets.only(left: 5),
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child:Text('開堂時間:${controller.model!.startTime}')
                // CustomDropdownButton2(
                //   dropdownWidth: Get.width-50,
                //   hint: '請選擇課程',
                //   dropdownItems: items,
                //   value: controller.model!.name,
                //   buttonDecoration: const BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(8))
                //   ),
                //   onChanged: (value) {
                //     // selectedValue = value;
                //     // controller.update();
                //   },
                // ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     //设置四周圆角 角度
              //     borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              //     //设置四周边框
              //     border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
              //   ),
              //   width: Get.width -50,
              //   child: CustomDropdownButton2(
              //     hint: '請選擇時間',
              //     dropdownWidth: Get.width-50,
              //     dropdownItems: timeItems,
              //     value: timeSelectedValue,
              //     buttonDecoration: const BoxDecoration(
              //         borderRadius: BorderRadius.all(Radius.circular(8))
              //     ),
              //     onChanged: (value) {
              //       timeSelectedValue = value;
              //       controller.update();
              //       // setState(() {
              //       //   selectedValue = value;
              //       // });
              //     },
              //   ),
              // ),
            ),

            const SizedBox(height: 15,),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  //设置四周圆角 角度
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  //设置四周边框
                  border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                ),
                width: Get.width -50,
                child: CustomDropdownButton2(
                  hint: '請選擇錢包',
                  dropdownWidth: Get.width-50,
                  dropdownItems: type,
                  value: typeSelectedValue,
                  iconEnabledColor: AppColor.themeColor,
                  iconDisabledColor: AppColor.themeColor,
                  buttonDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  onChanged: (value) {
                    typeSelectedValue = value;
                    controller.update();
                    // setState(() {
                    //   selectedValue = value;
                    // });
                  },
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 15),
              width: Get.width - 50,
              height: 45,
              decoration: BoxDecoration(
                  color: AppColor.themeColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
              child: MaterialButton(onPressed: () {
                if(typeSelectedValue == null){
                  BotToast.showText(text: '請選擇支付的錢包');
                  return;
                }
                if(typeSelectedValue == '共享錢包'){
                  controller.requestDataWithSubscribeCreate(1);
                }else{
                  controller.requestDataWithSubscribeCreate(0);
                }
              },
              child: const Text('預約',style: TextStyle(color: Colors.white),),
              ),
            ),
            Expanded(child:Container(
              width: Get.width,
              // height: 200,
              // alignment: Alignment.bottomRight,
              child: Image.asset('images/yuyuebg.png',fit: BoxFit.fitWidth,),
            ),)
          ],
        );
      }),
    );
  }

}