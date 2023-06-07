import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:yoga_student_app/common/colors.dart';
import 'package:yoga_student_app/lang/message.dart';
import '../../services/address.dart';
import '../../services/dio_manager.dart';

class NoticePage extends StatefulWidget {
  final int id;
  const NoticePage(this.id, {Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  /// 獲取公告詳情

  Map? _json;
  requestDataWithNoticeDetail() async {
    var params = {'method': 'notice.info', 'id': widget.id};
    var json = await DioManager().kkRequest(Address.host, bodyParams: params);

    _json = json;

    setState(() {});
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).padding.top + kToolbarHeight,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColor.themeColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                // image:DecorationImage(image: AssetImage('images/appbar_bg.png',),
                //   fit: BoxFit.fill,
                // ),
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 35),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 35),
                    child: const Text(
                      I18nContent.noticeDetailTitleLabel,
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              )),
          _json == null
              ? const Center(child: CupertinoActivityIndicator())
              : Expanded(
                  child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        // borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.all(15),
                      child: CachedNetworkImage(
                        imageUrl: '${_json?['data']['pic_url']}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Text(
                        '${_json?['data']['title']}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: HtmlWidget(
                        _json?['data']['body'] ?? '',
                        textStyle: TextStyle(fontSize: 11),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                )),
        ],
      ),
    );
  }
}
