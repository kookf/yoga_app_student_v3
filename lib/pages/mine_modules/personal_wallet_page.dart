import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/lang/message.dart';
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
  /// Credit充值記錄
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
      body: EasyRefresh.custom(
        controller: easyRefreshController,
        header: MaterialHeader(),
        footer: MaterialFooter1(),
        onLoad: () async {
          page++;
          requestDataWithWalletLog();
        },
        onRefresh: () async {
          page = 1;
          requestDataWithWalletLog();
        },
        slivers: [
          SliverToBoxAdapter(
            child: buildAppBarBackground(context),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 60,
              color: AppColor.themeColor,
              padding: const EdgeInsets.only(left: 75, right: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '類型',
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColor.themeTextColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    I18nContent.goldLabel,
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColor.themeTextColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: _mySliverChildBuilderDelegate(),
          ),
        ],
        // body: buildSliverBody(context),
      ),
    );
  }

  Widget buildAppBarBackground(BuildContext context) {
    return Column(
      children: [
        // Image.asset('images/appbar_bg.png',fit: BoxFit.fitWidth,width: Get.width,),
        Container(
          width: Get.width,
          height: 390,
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
                    I18nContent.myWalletLabel,
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
              Align(
                alignment: const Alignment(0, 1),
                child: MaterialButton(
                  onPressed: () {
                    Get.to(PayMethodPage(0));
                  },
                  color: AppColor.themeTextColor,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  minWidth: 120,
                  child: const Text(
                    I18nContent.reChargeLabel,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 50,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 15, left: 15),
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${I18nContent.goldLabel} ${userModel?.data?.balance ?? '0'}',
              style: TextStyle(
                  color: AppColor.themeTextColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        userModel?.data?.walletExpireAt == null
            ? const SizedBox()
            : Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Text(
                  '提示:Credit與${userModel?.data?.walletExpireAt}過期',
                  style:
                      TextStyle(color: AppColor.themeTextColor, fontSize: 12),
                ),
              ),
      ],
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          model.type == 1
                              ? '充值'
                              : model.type == 2
                                  ? '訂閲'
                                  : model.type == 3
                                      ? '管理員添加'
                                      : model.type == 12
                                          ? '客戶取消預約'
                                          : model.type == 13
                                              ? '管理員取消預約'
                                              : model.type == 21
                                                  ? 'Credit過期清除'
                                                  : '共享Credit過期清除',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: AppColor.themeTextColor),
                        ),
                        Text(
                          '${model.createdAt}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              color: AppColor.themeTextColor),
                        ),
                      ],
                    ),
                    Container(
                      height: 45,
                      width: 90,
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.themeTextColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text(
                        '${model.amount}',
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
