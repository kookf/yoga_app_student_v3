import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import '../../services/address.dart';
import '../../services/dio_manager.dart';
class NoticePage extends StatefulWidget {


  int id;
  NoticePage(this.id,{Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {


  /// 獲取公告詳情

  var _json;
  requestDataWithNoticeDetail()async{
    var params = {
      'method':'notice.info',
      'id':widget.id
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
                    }, icon: const Icon(Icons.arrow_back_ios),color: Colors.white,),
                  ),



                  Container(
                    padding: const EdgeInsets.only(top: 35),
                    child: const Text('公告',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                  ),


                ],
              )
          ),
          const SizedBox(height: 25,),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              // borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.all(15),
            child: CachedNetworkImage(
              imageUrl: '${Address.homeHost}'
                  '${_json['data']['pic_url']}',
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: Text('${_json['data']['title']}'),
          ),

          Container(
            padding: EdgeInsets.only(left: 25,right: 25),
            child: HtmlWidget(_json['data']['body']??''),
          ),
        ],
      ),
    );
  }
}
