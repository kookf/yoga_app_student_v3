import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/pages/mine_modules/shared_wallet_module/shared_wallet_log_model.dart';
import 'package:yoga_student_app/pages/mine_modules/user_model.dart';

import '../../common/colors.dart';
import '../../components/custom_footer.dart';
import '../../services/address.dart';
import '../../services/dio_manager.dart';
import '../payment_method_modules/payment_method_page.dart';

class PersonalWalletPage extends StatefulWidget {
  const PersonalWalletPage({Key? key}) : super(key: key);

  @override
  State<PersonalWalletPage> createState() => _PersonalWalletPageState();
}

class _PersonalWalletPageState extends State<PersonalWalletPage> {
  /// 錢包充值記錄
  var page = 1;

  EasyRefreshController easyRefreshController = EasyRefreshController();

  List dataArr = [];

  /// 獲取記錄
  void requestDataWithWalletLog() async {
    var params = {
      'method': 'auth.wallet_log',
      'page': page,
      'is_share_wallet': '0',
    };
    var json =
        await DioManager().kkRequest(Address.hostAuth, bodyParams: params);
    SharedWalletLogModel model = SharedWalletLogModel.fromJson(json);
    if (page == 1) {
      easyRefreshController.resetLoadState();
      dataArr.clear();
      dataArr.addAll(model.data!.list!);
    } else {
      if (model.data!.list!.isNotEmpty) {
        dataArr.addAll(model.data!.list!);
      } else {
        easyRefreshController.finishLoad(noMore: true);
        BotToast.showText(text: '暂无更多');
      }
    }
    setState(() {});
  }

  /// 獲取個人資料
  UserModel? userModel;

  void requestDataWithUserinfo() async {
    var params = {
      'method': 'auth.profile',
    };

    var json =
        await DioManager().kkRequest(Address.hostAuth, bodyParams: params);

    userModel = UserModel.fromJson(json);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDataWithWalletLog();
    requestDataWithUserinfo();
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
      expandedHeight: 440,
      elevation: 0,
      // backgroundColor:AppColor.themeColor,
      snap: false,
      actions: [
        TextButton(
            onPressed: () {
              Get.to(const PayMethodPage());
            },
            child: Text(
              '充值',
              style: TextStyle(color: AppColor.themeColor),
            ))
      ],
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
    return Column(
      children: [
        // Image.asset('images/appbar_bg.png',fit: BoxFit.fitWidth,width: Get.width,),
        SizedBox(
          width: Get.width,
          // color: Colors.red,
          height: 400,
          child: Stack(
            children: [
              SizedBox(
                width: Get.width,
                child: Image.asset(
                  'images/ic_mine_bg.png',
                  fit: BoxFit.fill,
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.65),
                child: Image.asset(
                  'images/login_log.png',
                  width: 150,
                  height: 150,
                ),
              ),
              Align(
                child: Container(
                  margin: const EdgeInsets.only(top: 45),
                  child: Text(
                    '個人錢包',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: AppColor.themeTextColor),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 0.95),
                child: Image.asset(
                  'images/ic_mine_jinbi.png',
                  width: 130,
                  height: 130,
                ),
              ),
            ],
          ),
        ),
        Text(
          '代幣 ${userModel?.data?.balance ?? '0'}',
          style: TextStyle(
              color: AppColor.themeTextColor,
              fontSize: 30,
              fontWeight: FontWeight.w700),
        ),
        userModel?.data?.walletExpireAt == null
            ? SizedBox()
            : Container(
                child: Text(
                '提示:代幣與${userModel?.data?.walletExpireAt}過期',
                style: TextStyle(color: AppColor.themeTextColor, fontSize: 12),
              )),
      ],
    );
  }

  Widget buildSliverBody(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      child: Column(
        children: [
          Expanded(
              child: EasyRefresh.custom(
                  controller: easyRefreshController,
                  header: MaterialHeader(),
                  footer: MaterialFooter1(),
                  onRefresh: () async {
                    page = 1;
                    requestDataWithWalletLog();
                    requestDataWithUserinfo();
                  },
                  onLoad: () async {
                    page++;
                    requestDataWithWalletLog();
                  },
                  emptyWidget: dataArr.isEmpty
                      ? const Center(child: Text('暫無信息'))
                      : null,
                  slivers: [
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

        /// 1 充值 2 订阅 3 管理员添加 12 客户取消订阅 13 管理员取消订阅 21 钱包过期清除 22 共享钱包过期清除


        SharedWalletLogList model = dataArr[index];
        return Container(
          // margin: const EdgeInsets.only(left: 30,right: 30,top: 0,bottom: 15),
          height: 80,
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
                        Text(
                          '金額:${model.amount}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 23,
                              color: AppColor.themeTextColor),
                        ),
                        Text(
                          '類型：${model.type==1?'充值':model.type==2?'訂閲':model.type==3?'管理员添加'
                          :model.type==12?'客户取消订阅':model.type==13?'管理员取消订阅':model.type==21?'钱包过期清除':
                              '共享钱包过期清除'
                          }',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              color: AppColor.themeTextColor),
                        ),
                      ],
                    ),
                    Container(
                      height: 45,
                      // width: 130,
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.themeTextColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text(
                        '      已購買與 \n ${model.createdAt}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    )
                  ],
                )),
          ),
        );
      },
      childCount: dataArr.length,
    );
  }
}
