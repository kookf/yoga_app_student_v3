import 'package:bot_toast/bot_toast.dart';
import 'package:bruno/bruno.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_student_app/pages/mine_modules/shared_wallet_module/shared_wallet_model.dart';
import 'package:yoga_student_app/services/address.dart';
import 'package:yoga_student_app/services/dio_manager.dart';
import '../../../common/colors.dart';

class SharedWalletPage extends StatefulWidget {
  const SharedWalletPage({Key? key}) : super(key: key);

  @override
  State<SharedWalletPage> createState() => _SharedWalletPageState();
}

class _SharedWalletPageState extends State<SharedWalletPage> {


  TextEditingController phoneTextEditingController = TextEditingController();


  ///獲取共享人列表
  SharedWalletModel? _sharedWalletModel;
  requestDataWithWalletUser()async{
    var params = {
      'method':'auth.wallet_user_list',
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);

    SharedWalletModel model = SharedWalletModel.fromJson(json);

    _sharedWalletModel = model;

    setState(() {

    });
  }

  ///添加共享人
  void requestDataWithAddWallet(String phone)async{
    var params = {
      'method':'auth.add_wallet_user',
      'phone':phone
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    BotToast.showText(text: json['message']);
    requestDataWithWalletUser();

  }
  /// 移處共享人
  void requestDataWithRemoveWallet(String id)async{
    var params = {
      'method':'auth.remove_wallet_user',
      'id':id
    };
    var json = await DioManager().kkRequest(Address.hostAuth,bodyParams: params);
    requestDataWithWalletUser();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDataWithWalletUser();
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
                    child: const Text('',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                  ),


                ],
              )
          ),

          SizedBox(
            width: Get.width,
            // color: Colors.red,
            height: 260,
            child: Stack(
              children: [
                SizedBox(
                  width: Get.width,
                  child: Image.asset('images/ic_mine_bg.png',fit: BoxFit.fill,),
                ),
                Align(alignment: const Alignment(0, -0.75),child:  Image.asset('images/login_log.png',width: 150,height: 150,),),

                Align(
                  child: Container(
                    margin: const EdgeInsets.only(top: 80),
                    child: Text('共享錢包',style: TextStyle(fontSize: 25,
                        fontWeight: FontWeight.w700,color: AppColor.themeTextColor),),
                  ),
                ),
                Align(
                  alignment: const Alignment(0, 5),
                  child: Image.asset('images/ic_duojinbi.png',width: 210,height: 210,),
                )

              ],
            ),

          ),

          const SizedBox(height: 50,),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Container(
               child: Text('         ',style: TextStyle(color: AppColor.themeTextColor,fontSize: 30,fontWeight: FontWeight.w700),),
             ),
             Container(
               child: Text('代幣 52,300',style: TextStyle(color: AppColor.themeTextColor,fontSize: 30,fontWeight: FontWeight.w700),),
             ),
             TextButton(onPressed: (){

             }, child: Text('解绑钱包',style: TextStyle(fontSize: 16,color: AppColor.themeTextColor),))
           ],
         ),
          Container(
            height: 110,
            color: AppColor.themeColor,
            padding: EdgeInsets.only(left: 35,right: 15,top: 5),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('錢包主人'),
                    Image.asset('images/header3.png',width: 75,height: 75,)
                  ],
                ),
                SizedBox(width: 15,),
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
                     child:  Text('钱包朋友'),
                   ),
                    Container(
                      height: 75,
                      width: Get.width - 150,
                      // color: Colors.red,
                      child: CustomScrollView(
                        scrollDirection: Axis.horizontal,
                        slivers: [
                          SliverList(delegate: _mySliverChildBuilderDelegate()),
                          SliverToBoxAdapter(
                            child: GestureDetector(
                              onTap: (){
                                BrnMiddleInputDialog(
                                    title: '請輸入手機號碼',
                                    hintText: '手機號碼',
                                    cancelText: '取消',
                                    confirmText: '确定',
                                    maxLength: 20,
                                    maxLines: 1,
                                    barrierDismissible: false,
                                    autoFocus: true,
                                    inputEditingController: phoneTextEditingController,
                                    // inputEditingController: TextEditingController()..text = 'bbb',
                                    textInputAction: TextInputAction.done,
                                    onConfirm: (value) {
                                      if(value.isEmpty){
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
                                    child:Image.asset('images/ic_add.png',width: 65,height: 65,),
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

                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Container(
                //       margin: EdgeInsets.only(left: 15),
                //       child:  Text('    '),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(top: 10),
                //       child:Image.asset('images/header5.png',width: 65,height: 65,),
                //     )
                //   ],
                // ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Container(
                //       margin: EdgeInsets.only(left: 15),
                //       child:  Text('    '),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(top: 10),
                //       child:Image.asset('images/header5.png',width: 65,height: 65,),
                //     )
                //   ],
                // ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Container(
                //       margin: EdgeInsets.only(left: 15),
                //       child:  Text('    '),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(top: 10),
                //       child:Image.asset('images/ic_add.png',width: 65,height: 65,),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
          Expanded(child: ListView(
            padding: EdgeInsets.only(top: 15),
            children: [
              GestureDetector(
                onTap: (){
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.black,
                            width: 0.3
                        )
                    ),
                    padding: EdgeInsets.only(left: 20,right: 15),
                    height: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('富貴逼人包（HK100）',style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 23,color: AppColor.themeTextColor),),
                        Container(
                          height: 40,
                          width: 130,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.themeTextColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text('      已購買與 \n 2022年12月16日',style: TextStyle(color: Colors.white,fontSize: 13),),
                        )                        ],
                    )
                ),
              ),
              GestureDetector(
                onTap: (){
                },
                child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(left: 20,right: 15),
                    height: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('富貴逼人包（HK100）',style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 23,color: AppColor.themeTextColor),),
                        Container(
                          height: 40,
                          width: 130,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.themeTextColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text('      已購買與 \n 2022年12月16日',style: TextStyle(color: Colors.white,fontSize: 13),),
                        )                        ],
                    )
                ),
              ),
              GestureDetector(
                onTap: (){
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.black,
                            width: 0.3
                        )
                    ),
                    padding: EdgeInsets.only(left: 20,right: 15),
                    height: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('富貴逼人包（HK100）',style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 23,color: AppColor.themeTextColor),),
                        Container(
                          height: 40,
                          width: 130,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.themeTextColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text('      已購買與 \n 2022年12月16日',style: TextStyle(color: Colors.white,fontSize: 13),),
                        )
                      ],
                    )
                ),
              ),

            ],
          ),),

        ],
      ),
    );
  }
  _mySliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
          (BuildContext context, int index) {
        return Center(
          child: Container(
            margin: const EdgeInsets.only(left: 1,right: 1),
            height: 80,
            width: 80,
            // color: Colors.yellowAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CircleAvatar(
                //   child: FlutterLogo(),
                // ),
                CachedNetworkImage(imageUrl: '${Address.homeHost}${_sharedWalletModel?.data?.list?[index].avatar}',
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 5,),
                Text('${_sharedWalletModel?.data?.list?[index].name}'),
              ],
            ),
          ),
        );
      },
      childCount: _sharedWalletModel?.data?.list?.length??1,
    );
  }


}
