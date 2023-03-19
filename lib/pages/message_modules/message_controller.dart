import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/pages/message_modules/message_model.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';

class MessagePageController extends GetxController{

  EasyRefreshController easyRefreshController = EasyRefreshController();


  List dataArr = [];

  onRefresh()async{
    int page = 1 ;
    requestDataWithNoticeList(page);
  }
  onLoad()async{
    int page = 1;
    page++;
    requestDataWithNoticeList(page);
  }



  requestDataWithNoticeList(int page )async{
    var params = {
      'method':'notice.list',
      'page':page,
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams:params);
    MessageModel model = MessageModel.fromJson(json);
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
        BotToast.showText(text: '暂无更多');
      }
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestDataWithNoticeList(1);
  }

}