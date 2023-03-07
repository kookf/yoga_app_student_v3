import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/colors.dart';

class PersonalWalletPage extends StatefulWidget {
  const PersonalWalletPage({Key? key}) : super(key: key);

  @override
  State<PersonalWalletPage> createState() => _PersonalWalletPageState();
}

class _PersonalWalletPageState extends State<PersonalWalletPage> {
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
                    padding: EdgeInsets.only(top: 35),
                    child:IconButton(onPressed: (){
                      Get.back();
                    }, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),
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
            height: 400,
            child: Stack(
              children: [
                Container(
                  child: Image.asset('images/ic_mine_bg.png',fit: BoxFit.fill,),
                  width: Get.width,
                ),
                Align(child:  Image.asset('images/login_log.png',width: 150,height: 150,),alignment: Alignment(0, -0.75),),

                Align(
                  child: Container(
                    margin: EdgeInsets.only(top: 45),
                    child: Text('個人錢包',style: TextStyle(fontSize: 25,
                        fontWeight: FontWeight.w700,color: AppColor.themeTextColor),),
                  ),
                ),
                Align(
                  child: Image.asset('images/ic_mine_jinbi.png',width: 130,height: 130,),
                  alignment: Alignment(0, 0.95),
                )

              ],
            ),

          ),

          Container(
            child: Text('代幣 52,300',style: TextStyle(color: AppColor.themeTextColor,fontSize: 30,fontWeight: FontWeight.w700),),
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
  Widget _itemBuilder(BuildContext context,int index){
    return Container(
      color: Colors.yellowAccent,
      child:Column(
        children: [
          Row(
            children: [
              Text('富貴逼人包'),
            ],
          ),
          Container(
            height: 0.3,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
