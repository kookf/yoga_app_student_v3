import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:yoga_student_app/common/colors.dart';
import 'package:get/get.dart';

class CounterDownPage extends StatefulWidget {
  final int time;

  const CounterDownPage(this.time, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CounterDownPageState();
  }
}

class _CounterDownPageState extends State<CounterDownPage> {
  // 用来在布局中显示相应的剩余时间
  String remainTimeStr = '';

  String? _hourStr;
  String? _minute;
  String? _second;

  Timer? _timer;

  //倒计时
  void startCountDown() {
    // 重新计时的时候要把之前的清除掉
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer!.cancel();
        _timer = null;
      }
    }

    if (widget.time <= 0) {
      return;
    }

    var countTime = widget.time;
    const repeatPeriod = Duration(seconds: 1);
    _timer = Timer.periodic(repeatPeriod, (timer) {
      if (countTime <= 0) {
        timer.cancel();
        _timer = null;
        //待付款倒计时结束，可以在这里做相应的操作

        BotToast.showText(text: '上課時間到');
        return;
      }
      countTime--;

      //外面传进来的单位是秒，所以需要根据总秒数，计算小时，分钟，秒
      int hour = countTime ~/ 3600;
      int minute = countTime % 3600 ~/ 60;
      int second = countTime % 60;

      var str = '';
      if (hour < 10) {
        _hourStr = '${str}0$hour';
      }
      if (hour > 10) {
        _hourStr = '$str$hour';
      }

      if (minute / 10 < 1) {
        //当只有个位数时，给前面加“0”，实现效果：“:01”,":02"
        _minute = str + '0' + minute.toString() + "";
      } else {
        _minute = "$str$minute";
      }

      if (second / 10 < 1) {
        _second = '${str}0$second';
      } else {
        _second = str + second.toString();
      }

      setState(() {
        remainTimeStr = str;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //开始倒计时，这里传入的是秒数
    startCountDown();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer!.cancel();
        _timer = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SizedBox(
          // color: Colors.red,
          width: Get.width,
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    border: Border.all(
                      color: AppColor.themeColor,
                      width: 6.0,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _hourStr ?? '--',
                      style: TextStyle(
                          color: AppColor.themeTextColor, fontSize: 22),
                    ),
                    Text(
                      '時',
                      style: TextStyle(
                          color: AppColor.themeTextColor, fontSize: 18),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    border: Border.all(
                      color: AppColor.themeColor,
                      width: 6.0,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _minute ?? '--',
                      style: TextStyle(
                          color: AppColor.themeTextColor, fontSize: 22),
                    ),
                    Text(
                      '分',
                      style: TextStyle(
                          color: AppColor.themeTextColor, fontSize: 18),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    border: Border.all(
                      color: AppColor.themeColor,
                      width: 6.0,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _second ?? '--',
                      style: TextStyle(
                          color: AppColor.themeTextColor, fontSize: 22),
                    ),
                    Text(
                      '秒',
                      style: TextStyle(
                          color: AppColor.themeTextColor, fontSize: 18),
                    )
                  ],
                ),
              ),

              // Text(remainTimeStr.length > 0 ? remainTimeStr: "--", style: TextStyle(
              //     fontSize: 18,
              //     color: Color.fromRGBO(255, 111, 50, 1),
              //     fontWeight: FontWeight.bold
              // ),),
            ],
          ),
        ),
      ),
    );
  }
}
