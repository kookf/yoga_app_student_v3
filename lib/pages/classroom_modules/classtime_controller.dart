import 'package:get/get.dart';
import 'package:yoga_student_app/services/dio_manager.dart';
import 'package:yoga_student_app/utils/persistent_storage.dart';

import '../../services/address.dart';
import 'classroom_model.dart';

class ClassTimeController extends GetxController{


  ClassRoomList? model;


  String? userName;


  requestDataWithSubscribeCreate()async{
    var params = {
      'method':'subscribe.create',
      'course_time_id':model?.courseTimeId,
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    model = Get.arguments;
    getName();
    print('model!.name ====== ${model!.name}');
  }

  getName()async{
    userName = await PersistentStorage().getStorage('name');
    print(userName);
    update();
  }

}