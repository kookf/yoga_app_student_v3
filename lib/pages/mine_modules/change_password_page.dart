import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';

import '../../common/colors.dart';
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {


  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController passwordNewTextEditingController = TextEditingController();
  TextEditingController passwordConfirmationTextEditingController = TextEditingController();


  requestDataWithChangePassWord()async{
    var params = {
      'method':'auth.change_password',
      'password':passwordTextEditingController.text,
      'password_new':passwordNewTextEditingController.text,
      'password_confirmation':passwordConfirmationTextEditingController.text,
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    if(json['code'] == 200){
      BotToast.showText(text: '修改成功');
      Get.back();
    }else{
      BotToast.showText(text: json['message']);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        padding: EdgeInsets.all(0),
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
                    child: const Text('密碼修改',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                  ),
                ],
              )
          ),
          const SizedBox(height: 40,),
          Center(
            child: Text('更改當前密碼',style: TextStyle(color: AppColor.themeTextColor,fontSize: 21,fontWeight: FontWeight.w700),),
          ),
          const SizedBox(height: 15,),
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
                controller: passwordTextEditingController,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(13) //限制长度
                ],
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '當前密碼'
                ),
                obscureText: true,
              ),
            ),
          ),
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
                controller: passwordNewTextEditingController,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(13) //限制长度
                ],
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '新密碼'
                ),
                obscureText: true,
              ),
            ),
          ),
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
                controller: passwordConfirmationTextEditingController,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(13) //限制长度
                ],
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '確認新密碼'
                ),
                obscureText: true,
              ),
            ),
          ),
          const SizedBox(height: 35,),
          GestureDetector(
            onTap: (){
              requestDataWithChangePassWord();
            },
            child:  Center(
              child:Container(
                height: 45,
                width: Get.width -50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: AppColor.themeColor,
                ),
                child: const Text('送出',style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
          Container(
            // height: 200,
            padding: EdgeInsets.only(top: 200),
            alignment: Alignment.bottomCenter,
            child: Image.asset('images/yuyuebg.png'),
          ),


        ],
      ),
    );
  }
}
