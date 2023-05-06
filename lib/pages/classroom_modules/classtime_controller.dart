import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/services/dio_manager.dart';
import 'package:yoga_student_app/utils/persistent_storage.dart';
import '../../common/eventbus.dart';
import '../../services/address.dart';
import '../mine_modules/appointment_record_page.dart';
import 'classroom_model.dart';

class ClassTimeController extends GetxController{


  Course? model;


  String? userName;


  requestDataWithSubscribeCreate(var isShareWallet)async{
    var params = {
      'method':'subscribe.create',
      'course_time_id':model?.courseTimeId,
      'is_share_wallet':isShareWallet,
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    if(json['code']==200){
      BotToast.showText(text: '預約成功');
      eventBus.fire(EventFn('refresh'));
      
      Get.to(AppointmentRecordPage());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    model = Get.arguments;
    getName();



  }

  getName()async{
    userName = await PersistentStorage().getStorage('name');
    print(userName);
    update();
  }

}