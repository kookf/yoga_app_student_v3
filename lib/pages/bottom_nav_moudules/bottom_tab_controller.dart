import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/colors.dart';
import '../../components/keep_alive_wrapper.dart';
import '../home_modules/home_view.dart';
import '../message_modules/message_page.dart';
import '../mine_modules/mine_view.dart';
import '../reserve_list_page.dart';
import 'bottom_controller.dart';



class TabPage extends GetView{

   int _currentIndex = 0;


  final pageController = PageController();

  TabPage({super.key});

   var _lastTime;

   Future<bool> _isExit()async {
     if (_lastTime == null ||
         DateTime.now().difference(_lastTime) > Duration(seconds: 2)) {
       _lastTime = DateTime.now();
       BotToast.showText(text: '在按一次退出應用');
       return Future.value(false);
     }
     return Future.value(true);
   }


  void onTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    // setState(() {
      _currentIndex = index;
      controller.update();
    // });
  }

  @override
  final BottomController controller = Get.put(BottomController());

  final List<Widget> _listPageData = [
    // const KeepAliveWrapper(child: HomeConver()),
    KeepAliveWrapper(child: HomeView()),
    const KeepAliveWrapper(child: ReserveListPage()),

    KeepAliveWrapper(child: MessagePage()),
    // const KeepAliveWrapper(child: ContactPage()),
    //  KeepAliveWrapper(child: MineView(),),
    MineView(),
    // MinePage(),
  ];
  @override

  Widget build(BuildContext context) {
    return GetBuilder<BottomController>(builder: (_){
      return WillPopScope(
        onWillPop: _isExit,
      child:  Scaffold(
        // body: _listPageData[_currentIndex],
        // body: bodyList[currentIndex],

        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: _listPageData, // 禁止滑动
        ),
        bottomNavigationBar:
        BottomNavigationBar(
          currentIndex: _currentIndex,//配置对应的索引值选中
          onTap: onTap,
          backgroundColor: AppColor.themeColor,
          iconSize: 20.0,//icon的大小
          fixedColor:Colors.black54,//选中颜色
          selectedFontSize: 12,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          // selectedItemColor: Colors.black54,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('images/home_bottom_icon.png',width: 36,height: 36,color: Colors.white,),
              activeIcon: Image.asset('images/home_bottom_icon.png',width: 36,height: 36,color: Colors.black54,),
              label: '首頁',
            ),
            BottomNavigationBarItem(
                icon: Image.asset('images/ic_bottom_calendar.png',width: 36,height: 36,color: Colors.white,),
                activeIcon: Image.asset('images/ic_bottom_calendar.png',width: 36,height: 36,color: Colors.black54,),
                label: '預約'
            ),
            BottomNavigationBarItem(
                icon: Image.asset('images/ic_message_bottom.png',width: 36,height: 36,color: Colors.white,),
                activeIcon: Image.asset('images/ic_message_bottom.png',width: 36,height: 36,color: Colors.black54,),
                label: '通知'
            ),
            BottomNavigationBarItem(
                icon: Image.asset('images/mine_bottom_icon.png',width: 36,height: 36,color: Colors.white,),
                activeIcon: Image.asset('images/mine_bottom_icon.png',width: 36,height: 36,color: Colors.black54,),
                label: '設定'
            ),
          ],
        ),

      ),
      );

    });

  }

}


// class Tabs extends StatefulWidget{
//   const Tabs({super.key});
//
//   @override
//   State<StatefulWidget> createState() {
//     return TabState();
//   }
// }
//
// class TabState extends State<Tabs>{
//
//   int _currentIndex = 0;
//
//
//   final pageController = PageController();
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//   }
//
//
//
//   void onTap(int index) {
//     pageController.jumpToPage(index);
//   }
//
//   void onPageChanged(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//
//   final List<Widget> _listPageData = [
//     // const KeepAliveWrapper(child: HomeConver()),
//      KeepAliveWrapper(child: HomeView()),
//      const KeepAliveWrapper(child: ReserveListPage()),
//
//      KeepAliveWrapper(child: MessagePage()),
//     // const KeepAliveWrapper(child: ContactPage()),
//     //  KeepAliveWrapper(child: MineView(),),
//     MineView(),
//     // MinePage(),
//   ];
//   @override
//
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // body: _listPageData[_currentIndex],
//       // body: bodyList[currentIndex],
//
//       body: PageView(
//         controller: pageController,
//         onPageChanged: onPageChanged,
//         physics: const NeverScrollableScrollPhysics(),
//         children: _listPageData, // 禁止滑动
//       ),
//       bottomNavigationBar:
//       BottomNavigationBar(
//         currentIndex: _currentIndex,//配置对应的索引值选中
//         onTap: onTap,
//         backgroundColor: AppColor.themeColor,
//         iconSize: 20.0,//icon的大小
//         fixedColor:Colors.black54,//选中颜色
//         selectedFontSize: 12,
//         unselectedItemColor: Colors.white,
//         type: BottomNavigationBarType.fixed,
//         // selectedItemColor: Colors.black54,
//         items: [
//           BottomNavigationBarItem(
//               icon: Image.asset('images/home_bottom_icon.png',width: 36,height: 36,color: Colors.white,),
//               activeIcon: Image.asset('images/home_bottom_icon.png',width: 36,height: 36,color: Colors.black54,),
//               label: '首頁',
//           ),
//           BottomNavigationBarItem(
//               icon: Image.asset('images/ic_bottom_calendar.png',width: 36,height: 36,color: Colors.white,),
//               activeIcon: Image.asset('images/ic_bottom_calendar.png',width: 36,height: 36,color: Colors.black54,),
//               label: '預約'
//           ),
//           BottomNavigationBarItem(
//               icon: Image.asset('images/ic_message_bottom.png',width: 36,height: 36,color: Colors.white,),
//               activeIcon: Image.asset('images/ic_message_bottom.png',width: 36,height: 36,color: Colors.black54,),
//               label: '通知'
//           ),
//           BottomNavigationBarItem(
//               icon: Image.asset('images/mine_bottom_icon.png',width: 36,height: 36,color: Colors.white,),
//               activeIcon: Image.asset('images/mine_bottom_icon.png',width: 36,height: 36,color: Colors.black54,),
//               label: '設定'
//           ),
//         ],
//       ),
//
//     );
//
//
//
//   }
// }