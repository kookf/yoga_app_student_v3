import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/pages/student_login_modules/register_module/register_controller.dart';
import '../../../common/colors.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class RegisterView extends GetView{

  @override
  final RegisterController controller = Get.put(RegisterController());

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<RegisterController>(builder: (_){
        return Scaffold(

          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black
            ),
          ),
          body: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 25),
                alignment: Alignment.center,
                child: Text('學生註冊',style: TextStyle(fontSize: 31,color: AppColor.themeColor,fontWeight: FontWeight.w700),),
              ),
              const SizedBox(height: 25,),
              Center(
                child:  Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: 15),
                  width: Get.width-50,
                  //边框设置
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                  ),
                  child: TextField(
                    controller: controller.nameTextEditingController,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(13) //限制长度
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '用戶名稱'
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Center(
                child:  Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: 15),
                  width: Get.width-50,
                  //边框设置
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                  ),
                  child: TextField(
                    controller: controller.emailTextEditingController,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(50) //限制长度
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '郵件'
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Center(
                child:Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: 15),
                  width: Get.width-50,
                  //边框设置
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                  ),
                  child: TextField(
                    controller: controller.phoneTextEditingController,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20) //限制长度
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '用戶電話'
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              GestureDetector(
                onTap: (){
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1980, 1, 1),
                      maxTime: DateTime(2099, 6, 7),
                      theme: DatePickerTheme(
                          headerColor: AppColor.themeColor,
                          backgroundColor: AppColor.themeColor,
                          itemStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                          const TextStyle(color: Colors.white, fontSize: 16)),
                      onChanged: (date) {

                      }, onConfirm: (date) {

                        String dateStr = '${date.year}-${date.month}-${date.day}';
                        print('confirm ${dateStr}');
                        controller.birth = dateStr;
                        controller.birthController.text = dateStr;
                        controller.update();
                    }, currentTime: DateTime(1998),);
                },
                child: Center(
                  child:Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.only(left: 15),
                    width: Get.width-50,
                    //边框设置
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      //设置四周圆角 角度
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      //设置四周边框
                      border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                    ),
                    child: TextField(
                      enabled: false,
                      controller: controller.birthController,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(25) //限制长度
                      ],
                      decoration:  InputDecoration(
                          border: InputBorder.none,
                          hintText: '出生日期（年/月/日）',
                        hintStyle: TextStyle(color: AppColor.themeColor)
                      ),
                    ),
                  ),
                ),
              ),
              const  SizedBox(height: 5,),
              Center(
                child:  Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: 15),
                  width: Get.width-50,
                  //边框设置
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),
                  ),
                  child: TextField(
                    obscureText: true,
                    controller: controller.passwordTextEditingController,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(25) //限制长度
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '密碼'
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Center(
                child:  Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: 15),
                  width: Get.width-50,
                  //边框设置
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border:  Border.all(width: 1, color: AppColor.textFieldBorderColor),

                  ),
                  child: TextField(
                    obscureText: true,
                    controller: controller.passwordConfirmationController,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(25) //限制长度
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '確認密碼'
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25,),
              GestureDetector(
                onTap: (){
                  controller.requestDataWithRegister();
                },
                child: Center(
                  child:Container(
                    height: 45,
                    width: Get.width -50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: AppColor.themeColor,
                    ),
                    child: const Text('註冊賬號',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              Container(
                // color: Colors.red,
                alignment: Alignment.bottomCenter,
                child: Image.asset('images/yuyuebg.png',fit: BoxFit.fill,),
              )
              // Expanded(child: Container(
              //   // color: Colors.red,
              //   alignment: Alignment.bottomCenter,
              //   child: Image.asset('images/yuyuebg.png',fit: BoxFit.fill,),
              // ),)
            ],
          ),
        );
      }),
    );
  }

}