import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/pages/mine_modules/charge_log_modules/charge_log_model.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';
import '../../../common/colors.dart';
import '../../../components/custom_footer.dart';
import '../../classroom_modules/classroom_calendar_page.dart';

class PurchaseHistoryPage extends StatefulWidget {
  int currentIndex = 1;
  PurchaseHistoryPage({required this.currentIndex, Key? key}) : super(key: key);

  @override
  State<PurchaseHistoryPage> createState() => _PurchaseHistoryPageState();
}

class _PurchaseHistoryPageState extends State<PurchaseHistoryPage> {
  // int selectIndex = 1;

  int page = 1;

  EasyRefreshController easyRefreshController = EasyRefreshController();

  List dataArr = [];

  String createDate = '';

  /// Credit購買後去待審批=0，已審批去成功審批=1，未通過去未獲通過=2
  ///
  requestDataWithChargeLog() async {
    var params = {
      'method': 'charge.log',
      'page': page,
      'pay_status': widget.currentIndex,

      ///待審批=0，已審批去成功審批=1，未通過去未獲通過=2
      'is_share_wallet': '',
      'create_date': createDate
    };
    var json =
        await DioManager().kkRequest(Address.hostAuth, bodyParams: params);

    ChargeLogModel model = ChargeLogModel.fromJson(json);
    if (page == 1) {
      easyRefreshController.resetLoadState();
      dataArr.clear();
      dataArr.addAll(model.data!.list!);
    } else {
      if (model.data!.list!.isNotEmpty) {
        dataArr.addAll(model.data!.list!);
      } else {
        easyRefreshController.finishLoad(noMore: true);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDataWithChargeLog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: _headerSliverBuilder,
        body: buildSliverBody(context),
      ),
    );
  }

  ///页面滚动头部处理
  List<Widget> _headerSliverBuilder(
      BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[buildSliverAppBar(context)];
  }

  ///导航部分渲染
  Widget buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: 210,
      elevation: 0,
      // backgroundColor:AppColor.themeColor,
      snap: false,
      iconTheme: const IconThemeData(color: Colors.black),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          '',
          style: TextStyle(
            color: AppColor.themeTextColor,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        background: buildAppBarBackground(context),
      ),
    );
  }

  Widget buildAppBarBackground(BuildContext context) {
    return Stack(
      children: [
        // Image.asset('images/appbar_bg.png',fit: BoxFit.fitWidth,width: Get.width,),

        Center(
          child: Container(
            // height: 140,
            alignment: Alignment.topCenter,
            // color: Colors.red,
            child: Image.asset(
              'images/ic_bg.png',
              width: Get.width,
              fit: BoxFit.cover,
            ),
          ),
        ),

        Align(
          alignment: const Alignment(0, -0.8),
          child: Container(
            width: Get.width,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 25),
            // height: 200,
            // color: Colors.redAccent,
            // color: Colors.redAccent,
            child: Column(
              children: [
                Image.asset(
                  'images/login_log.png',
                  width: 130,
                  height: 130,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  '購買記錄',
                  style: TextStyle(
                      color: AppColor.themeTextColor,
                      fontSize: 21,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSliverBody(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      child: Column(
        children: [
          Container(
            height: 0.5,
            width: Get.width,
            color: Colors.black,
          ),
          Container(
            height: 60,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      page = 1;
                      widget.currentIndex = 1;
                      requestDataWithChargeLog();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 80,
                    decoration: BoxDecoration(
                        color: widget.currentIndex == 1
                            ? AppColor.themeColor
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      '成功審批',
                      style: TextStyle(
                          fontSize: 18,
                          color: widget.currentIndex == 1
                              ? Colors.white
                              : AppColor.themeTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.currentIndex = 0;
                      page = 1;
                      requestDataWithChargeLog();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 80,
                    decoration: BoxDecoration(
                        color: widget.currentIndex == 0
                            ? AppColor.themeColor
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      '待審批',
                      style: TextStyle(
                          fontSize: 18,
                          color: widget.currentIndex == 0
                              ? Colors.white
                              : AppColor.themeTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.currentIndex = 2;
                      page = 1;
                      requestDataWithChargeLog();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 80,
                    decoration: BoxDecoration(
                        color: widget.currentIndex == 2
                            ? AppColor.themeColor
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      '未獲通過',
                      style: TextStyle(
                          fontSize: 18,
                          color: widget.currentIndex == 2
                              ? Colors.white
                              : AppColor.themeTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: ()async{
                //    var data = await Get.to(const ClassRoomCalendarPage());
                //    if(data != null){
                //      page = 1;
                //      createDate = data;
                //      requestDataWithChargeLog();
                //    }
                //   },
                //   child:Image.asset('images/ic_classroom_right.png',width: 40,height: 40,),
                // )
              ],
            ),
          ),
          Expanded(
              child: EasyRefresh.custom(
                  controller: easyRefreshController,
                  header: MaterialHeader(),
                  footer: MaterialFooter1(),
                  onRefresh: () async {
                    page = 1;
                    requestDataWithChargeLog();
                  },
                  onLoad: () async {
                    page++;
                    requestDataWithChargeLog();
                  },
                  emptyWidget: dataArr.isEmpty
                      ? const Center(child: Text('暫無信息'))
                      : null,
                  slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 60,
                    color: AppColor.themeColor,
                    padding: const EdgeInsets.only(left: 55, right: 55),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '單號',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColor.themeTextColor,
                              fontWeight: FontWeight.w600),
                        ),
                        // Text('狀態',style: TextStyle(fontSize: 20,
                        //     color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: _mySliverChildBuilderDelegate(),
                ),
              ])),
        ],
      ),
    );
  }

  SliverChildBuilderDelegate _mySliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        ChargeLogList model = dataArr[index];
        return Container(
          // margin: const EdgeInsets.only(left: 30,right: 30,top: 0,bottom: 15),
          height: 180,
          color: AppColor.bgColor,
          child: GestureDetector(
            onTap: () {},
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 0.3)),
                padding: const EdgeInsets.only(left: 15, right: 15),
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${model.orderNo}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 21,
                              color: AppColor.themeTextColor),
                        ),
                        model.payTime == null
                            ? const SizedBox()
                            : const SizedBox(
                                height: 10,
                              ),
                        model.payTime == null
                            ? const SizedBox()
                            : Text(
                                '支付時間：${model.payTime}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                    color: AppColor.themeTextColor),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '創建時間：${model.createdAt}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              color: AppColor.themeTextColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        model.cause == null
                            ? Text(
                                '備註：暫無備註',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.themeTextColor),
                              )
                            : Text(
                                '備註：${model.cause}',
                                style: TextStyle(
                                    color: AppColor.themeTextColor,
                                    fontWeight: FontWeight.w700),
                              ),

                        // model.payStatus==1?Text('已支付 HK\$${model.amount}',style: TextStyle(color: AppColor.themeTextColor,fontSize: 17
                        //   ,fontWeight: FontWeight.w700,
                        // )):Text('未支付 HK\$${model.amount}',style: TextStyle(color: AppColor.themeTextColor,fontSize: 17
                        // ,fontWeight: FontWeight.w700,
                        // ),),
                        TextButton(
                            onPressed: () {
                              // ImagePickers.previewImage('${Address.homeHost}/storage/${model.image}');
                              Get.dialog(Center(
                                child: SizedBox(
                                  width: 250,
                                  height: 250,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "${Address.homeHost}/storage/${model.image}",
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.fill,
                                    width: 250,
                                    height: 250,
                                  ),
                                ),
                              ));
                            },
                            child: Text(
                              '查看上傳憑證',
                              style: TextStyle(color: AppColor.themeTextColor),
                            ))
                      ],
                    ),
                  ],
                )),
          ),
        );
      },
      childCount: dataArr.length,
    );
  }
}
