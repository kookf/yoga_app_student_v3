import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../../common/colors.dart';

class PurchaseHistoryPage extends StatefulWidget {
  const PurchaseHistoryPage({Key? key}) : super(key: key);

  @override
  State<PurchaseHistoryPage> createState() => _PurchaseHistoryPageState();
}

class _PurchaseHistoryPageState extends State<PurchaseHistoryPage> {


  int selectIndex = 1;


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
  List<Widget> _headerSliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget> [
      buildSliverAppBar(context)
    ];
  }
  ///导航部分渲染
  Widget buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: 240,
      elevation: 0,
      // backgroundColor:AppColor.themeColor,
      snap: false,
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      flexibleSpace: FlexibleSpaceBar(
        title:  Text('購買記錄', style: TextStyle(
          color: AppColor.themeTextColor,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),) ,
        centerTitle: true,
        background: buildAppBarBackground(context),
      ),
    );
  }

  Widget buildAppBarBackground(BuildContext context) {
    return Stack(
      children: [
        // Image.asset('images/appbar_bg.png',fit: BoxFit.fitWidth,width: Get.width,),
        Align(
          alignment: const Alignment(0, -0.8),
          child:Container(
            width: Get.width,
            margin: EdgeInsets.only(top: 90),
            // height: 200,
            // color: Colors.redAccent,
            // color: Colors.redAccent,
            child: Column(
              children: [
                Image.asset('images/login_log.png',width: 130,height: 130,),
                const SizedBox(height: 15,),
              ],
            ),
          ),
        ),

        Center(
          child: Container(
            // height: 140,
            alignment: Alignment.topCenter,
            // color: Colors.red,
            child: Image.asset('images/ic_bg.png',width: Get.width,fit: BoxFit.cover,),
          ),
        ),

        // Container(
        //   margin: EdgeInsets.only(top: 100),
        //   child: Center(
        //     child: Text('預約課堂',style: TextStyle(fontSize: 22,color: AppColor.themeTextColor,
        //         fontWeight: FontWeight.w700
        //     ),),
        //   ),
        // ),

      ],
    );
  }

  Widget buildSliverBody(BuildContext context){
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
                  onTap: (){
                    setState(() {
                      selectIndex =1;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 80,
                    decoration: BoxDecoration(
                        color: selectIndex ==1? AppColor.themeColor:Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child:Text('已購買',style: TextStyle(fontSize: 22,color:selectIndex==1?Colors.white:AppColor.themeTextColor,fontWeight: FontWeight.w700),),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    print('object');
                    setState(() {
                      selectIndex =2;
                    });
                    print(selectIndex);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 80,
                    decoration: BoxDecoration(
                        color: selectIndex ==2? AppColor.themeColor:Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child:Text('已取消',style: TextStyle(fontSize: 22,color:selectIndex==2?Colors.white:AppColor.themeTextColor,fontWeight: FontWeight.w700),),
                  ),
                ),

                Image.asset('images/ic_classroom_right.png'),

              ],
            ),
          ),
          Expanded(child: EasyRefresh.custom(
            // emptyWidget:controller.dataArr.isEmpty?const Center(child:Text('暫無信息')):null,
              slivers: [

                SliverToBoxAdapter(
                  child:   Container(
                    height: 60,
                    color: AppColor.themeColor,
                    padding: EdgeInsets.only(left: 55,right: 55),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('課程名稱',style: TextStyle(fontSize: 20,color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
                        Text('狀態',style: TextStyle(fontSize: 20,color: AppColor.themeTextColor,fontWeight: FontWeight.w600),),
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
        return Container(
          // margin: const EdgeInsets.only(left: 30,right: 30,top: 0,bottom: 15),
          height: 80,
          color: AppColor.bgColor,
          child: GestureDetector(
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
                padding: EdgeInsets.only(left: 15,right: 15),
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('成人減壓班1222',style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 23,color: AppColor.themeTextColor),),
                        Text('日期：2022年12月22如（星期四）',style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 17,color: AppColor.themeTextColor),),
                      ],
                    ),
                    Container(
                      height: 45,
                      // width: 130,
                      padding: EdgeInsets.all(5),
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
        );
      },
      childCount: 3,
    );
  }

}
