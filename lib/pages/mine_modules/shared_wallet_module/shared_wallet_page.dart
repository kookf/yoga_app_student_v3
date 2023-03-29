import 'package:bot_toast/bot_toast.dart';
import 'package:bruno/bruno.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/pages/mine_modules/shared_wallet_module/shared_wallet_log_model.dart';
import 'package:yoga_student_app/pages/mine_modules/shared_wallet_module/shared_wallet_model.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';
import 'package:yoga_student_app/utils/persistent_storage.dart';
import '../../../common/colors.dart';
import '../../../components/custom_footer.dart';
import '../../payment_method_modules/payment_method_page.dart';
import 'package:get/get.dart';
class SharedWalletPage extends StatefulWidget {
  const SharedWalletPage({Key? key}) : super(key: key);

  @override
  State<SharedWalletPage> createState() => _SharedWalletPageState();
}

class _SharedWalletPageState extends State<SharedWalletPage> {
  bool isUnite = false;

  TextEditingController phoneTextEditingController = TextEditingController();

  ///獲取共享人列表
  SharedWalletModel? _sharedWalletModel;

  requestDataWithWalletUser() async {
    var params = {
      'method': 'auth.wallet_info',
    };
    var json =
        await DioManager().kkRequest(Address.hostAuth, bodyParams: params);

    SharedWalletModel model = SharedWalletModel.fromJson(json);

    _sharedWalletModel = model;

    setState(() {});
  }

  ///添加共享人
  void requestDataWithAddWallet(String phone) async {
    var params = {'method': 'auth.add_wallet_user', 'phone': phone};
    var json =
        await DioManager().kkRequest(Address.hostAuth, bodyParams: params);
    BotToast.showText(text: json['message']);
    if(json['code'] ==200){

      Get.back();
    }
    requestDataWithWalletUser();
    requestDataWithWalletLog();
  }

  /// 移處共享人
  void requestDataWithRemoveWallet(String id) async {
    var params = {'method': 'auth.remove_wallet_user', 'id': id};
    var json =
        await DioManager().kkRequest(Address.hostAuth, bodyParams: params);
    print('remove == ${json}');
    if (json['code'] == 200) {

      BotToast.showText(text: '移除成功');
      Get.back();
      Get.back();
      // requestDataWithWalletUser();
    }
    // requestDataWithWalletUser();
  }

  /// 共享錢包充值記錄
  var page = 1;

  EasyRefreshController easyRefreshController = EasyRefreshController();

  List dataArr = [];

  void requestDataWithWalletLog() async {
    var params = {
      'method': 'auth.wallet_log',
      'page': page,
      'is_share_wallet': '1',
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDataWithWalletLog();
    requestDataWithWalletUser();
    getAvatar();
  }

  String avatar = '';
  getAvatar()async{
    avatar =  await PersistentStorage().getStorage('avatar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //
      // ),
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
            requestDataWithWalletUser();
          },
          slivers: [
            SliverToBoxAdapter(
              child: buildAppBarBackground(context),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 110,
                color: AppColor.themeColor,
                padding: EdgeInsets.only(left: 35, right: 15, top: 5),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('錢包主人'),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(35)),
                          ),
                          width: 70,
                          height: 70,
                          clipBehavior: Clip.hardEdge,
                          child: CachedNetworkImage(
                            imageUrl:
                            '${Address.homeHost}/storage/${avatar}',
                            placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Image.asset(
                        //   'images/header3.png',
                        //   width: 75,
                        //   height: 75,
                        // )
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 110,
                      width: 0.3,
                      color: Colors.black,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text('錢包朋友'),
                        ),
                        Container(
                          height: 75,
                          width: Get.width - 150,
                          // color: Colors.red,
                          child: CustomScrollView(
                            scrollDirection: Axis.horizontal,
                            slivers: [
                              SliverList(
                                  delegate: _mySliverChildBuilderDelegate()),
                              SliverToBoxAdapter(
                                child: GestureDetector(
                                  onTap: () {
                                    BrnMiddleInputDialog(
                                        title: '請輸入手機號碼',
                                        hintText: '手機號碼',
                                        cancelText: '取消',
                                        confirmText: '确定',
                                        maxLength: 20,
                                        maxLines: 1,
                                        barrierDismissible: false,
                                        autoFocus: true,
                                        inputEditingController:
                                            phoneTextEditingController,
                                        // inputEditingController: TextEditingController()..text = 'bbb',
                                        textInputAction: TextInputAction.done,
                                        onConfirm: (value) {
                                          if (value.isEmpty) {
                                            BotToast.showText(text: '請輸入手機號碼');
                                            return;
                                          }
                                          requestDataWithAddWallet(value);
                                          // BrnToast.show(value, context);
                                        },
                                        onCancel: () {
                                          // BrnToast.show("取消", context);
                                          Navigator.pop(context);
                                        }).show(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    padding: EdgeInsets.only(left: 10,bottom: 15),
                                    child: Image.asset(
                                      'images/ic_add.png',
                                      width: 55,
                                      height: 55,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                        // Container(
                        //   width: double.infinity,
                        //   color: Colors.red,
                        //   margin: EdgeInsets.only(top: 5),
                        //   child:Image.asset('images/header5.png',width: 65,height: 65,),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: _mySliverChildBuilderDelegate1(),
            ),
          ]),
    );

  }

  Widget buildAppBarBackground(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,
          // color: Colors.red,
          height: 380,
          child: Stack(
            children: [
              Container(
                width: Get.width,
                child: Image.asset(
                  'images/ic_mine_bg.png',
                  fit: BoxFit.fill,
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.55),
                child: Image.asset(
                  'images/login_log.png',
                  width: 150,
                  height: 150,
                ),
              ),
              Align(
                child: Container(
                  margin: const EdgeInsets.only(top: 70),
                  child: Text(
                    '共享錢包',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: AppColor.themeTextColor),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 1.3),
                child: Image.asset(
                  'images/ic_duojinbi.png',
                  width: 210,
                  height: 210,
                ),
              ),
              Align(
                alignment: const Alignment(0, 1.0),
                child: MaterialButton(onPressed: (){
                  Get.to(PayMethodPage(1));
                },
                  color: AppColor.themeTextColor,elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),minWidth: 120,
                  child: const Text('充值',style: TextStyle(color: Colors.white),),) ,
              ),
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child:Container(
                  width: 50,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+15,left: 15),
                  child:const Align(
                    alignment:Alignment.topLeft,
                    child: Icon(Icons.arrow_back,color: Colors.black87,),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                '         ',
                style: TextStyle(
                    color: AppColor.themeTextColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10,bottom: 15),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text:
                          '代幣 ${_sharedWalletModel?.data?.owner?.balance ?? 0}',
                      style: TextStyle(
                          color: AppColor.themeTextColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w700)),
                ]),
              ),

              // Text('代幣 ${_sharedWalletModel?.data?.owner?.balance??0}',
              //   style: TextStyle(color: AppColor.themeTextColor,
              //       fontSize: 30,fontWeight: FontWeight.w700),),
            ),
            TextButton(
                onPressed: () {
                  // requestDataWithRemoveWallet(id)
                  if(_sharedWalletModel?.data?.owner ==null){
                    BotToast.showText(text: '暫無共享人員');
                    return;
                  }
                  isUnite = !isUnite;
                  setState(() {});
                },
                child: Text(
                  '解绑钱包',
                  style:
                      TextStyle(fontSize: 18,
                          color: AppColor.themeTextColor,fontWeight: FontWeight.w700),
                ))
          ],
        ),
        _sharedWalletModel?.data?.owner == null
            ? SizedBox()
            : Container(
                child: Text(
                  '提示:代幣與${_sharedWalletModel?.data?.owner?.walletExpireAt}過期',
                  style:
                      TextStyle(color: AppColor.themeTextColor, fontSize: 12),
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
          Expanded(
              child: EasyRefresh.custom(
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
                    requestDataWithWalletUser();
                  },
                  emptyWidget: dataArr.isEmpty
                      ? const Center(child: Text('暫無信息'))
                      : null,
                  slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 110,
                    color: AppColor.themeColor,
                    padding: EdgeInsets.only(left: 35, right: 15, top: 5),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('錢包主人'),
                            Image.asset(
                              'images/header3.png',
                              width: 75,
                              height: 75,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 110,
                          width: 0.3,
                          color: Colors.black,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text('钱包朋友'),
                            ),
                            Container(
                              height: 75,
                              width: Get.width - 150,
                              // color: Colors.red,
                              child: CustomScrollView(
                                scrollDirection: Axis.horizontal,
                                slivers: [
                                  SliverList(
                                      delegate:
                                          _mySliverChildBuilderDelegate()),
                                  SliverToBoxAdapter(
                                    child: GestureDetector(
                                      onTap: () {
                                        BrnMiddleInputDialog(
                                            title: '請輸入手機號碼',
                                            hintText: '手機號碼',
                                            cancelText: '取消',
                                            confirmText: '确定',
                                            maxLength: 20,
                                            maxLines: 1,
                                            barrierDismissible: false,
                                            autoFocus: true,
                                            inputEditingController:
                                                phoneTextEditingController,
                                            // inputEditingController: TextEditingController()..text = 'bbb',
                                            textInputAction:
                                                TextInputAction.done,
                                            onConfirm: (value) {
                                              if (value.isEmpty) {
                                                BotToast.showText(
                                                    text: '請輸入手機號碼');
                                                return;
                                              }
                                              requestDataWithAddWallet(value);
                                              // BrnToast.show(value, context);
                                            },
                                            onCancel: () {
                                              // BrnToast.show("取消", context);
                                              Navigator.pop(context);
                                            }).show(context);
                                      },
                                      child: Container(

                                        color: Colors.red,
                                        margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.only(left: 15),
                                        child: Image.asset(
                                          'images/ic_add.png',
                                          width: 55,
                                          height: 55,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                            // Container(
                            //   width: double.infinity,
                            //   color: Colors.red,
                            //   margin: EdgeInsets.only(top: 5),
                            //   child:Image.asset('images/header5.png',width: 65,height: 65,),
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: _mySliverChildBuilderDelegate1(),
                ),
              ])),
        ],
      ),
    );
  }

  _mySliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Center(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 1, right: 1),
                height: 80,
                width: 80,
                // color: Colors.yellowAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   child: FlutterLogo(),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      width: 50,
                      height: 50,
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl:
                            '${Address.homeHost}/storage/${_sharedWalletModel?.data?.userList?[index].avatar}',
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 20,
                      child: Text(
                          '${_sharedWalletModel?.data?.userList?[index].name}'),
                    )
                  ],
                ),
              ),
              isUnite == false
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                            title: '提示',
                            middleText: '是否移除當前用戶',
                            textCancel: '取消',
                            textConfirm: '確定',
                            onConfirm: () {
                              requestDataWithRemoveWallet(
                                  '${_sharedWalletModel?.data?.userList?[index].id}');
                              requestDataWithWalletUser();
                              // _sharedWalletModel?.data
                              isUnite = false;
                            },
                            onCancel: () {});
                      },
                      child: Image.asset(
                        'images/ic_yichu.png',
                        width: 20,
                        height: 20,
                        color: Colors.red,
                      ),
                    )
            ],
          ),
        );
      },
      childCount: _sharedWalletModel?.data?.userList?.length ?? 0,
    );
  }

  SliverChildBuilderDelegate _mySliverChildBuilderDelegate1() {
    return SliverChildBuilderDelegate(
      (BuildContext context, int index) {
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
                          '${model.type == 1 ? '充值' : model.type == 2 ? '訂閲' : model.type == 3 ? '管理员添加' : model.type == 12 ? '客户取消订阅' : model.type == 13 ? '管理员取消订阅' : model.type == 21 ? '钱包过期清除' : '共享钱包过期清除'}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 21,
                              color: AppColor.themeTextColor),
                        ),
                        Text(
                          '${model.createdAt}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              color: AppColor.themeTextColor),
                        ),

                        // Text('日期：${model.createdAt}',style: TextStyle(fontWeight: FontWeight.w700,
                        //     fontSize: 17,color: AppColor.themeTextColor),),
                      ],
                    ),
                    Container(
                      height: 45,
                      width: 100,
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.themeTextColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text('${model.amount}',
                        style: TextStyle(color: Colors.white, fontSize: 13),
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
