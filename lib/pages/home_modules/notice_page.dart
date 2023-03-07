import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import '../../services/address.dart';
import '../../services/dio_manager.dart';
class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {


  /// 獲取公告詳情

  var _json;
  requestDataWithNoticeDetail()async{
    var params = {
      'method':'notice.info',
    };
    var json = await DioManager().kkRequest(Address.host,bodyParams:params);

    _json = json;

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDataWithNoticeDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    }, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 35),
                    child: const Text('公告',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                  ),


                ],
              )
          ),
          SizedBox(height: 25,),
          Center(
            child: HtmlWidget(_json['data']['body']??''),
          ),
        ],
      ),
    );
  }
}
