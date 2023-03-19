import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yoga_student_app/common/colors.dart';
import '../../components/gradient_button.dart';
import 'package:get/get.dart';
class ClassRoomCalendarPage extends StatefulWidget {

  const ClassRoomCalendarPage({Key? key}) : super(key: key);

  @override
  State<ClassRoomCalendarPage> createState() => _ClassRoomCalendarPageState();
}

class _ClassRoomCalendarPageState extends State<ClassRoomCalendarPage> {



  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
          // IconButton(onPressed: (){
          //
          // }, icon: Image.asset('images/message_icon.png'))
        // ],
        backgroundColor: AppColor.themeColor,
        iconTheme: const IconThemeData(
          color: Colors.white, //修改颜色
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppColor.themeColor,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
            ),
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('選擇查詢日期',style: TextStyle(fontSize: 18,color: Colors.white),),
                // Text('成人減壓班1201 陳大明#2368',style: TextStyle(fontSize: 18,color: Colors.white),),
              ],
            )
          ),
          _buildDefaultSingleDatePickerWithValue(),
        ],
      ),
    );
  }
  Widget _buildDefaultSingleDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: AppColor.themeColor,
      weekdayLabels: ['日', '一', '二', '三', '四', '五', '六'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w400,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      // selectableDayPredicate: (day) => !day
      //     .difference(DateTime.now().subtract(const Duration(days: 31)))
      //     .isNegative,
    );
    return Column(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        CalendarDatePicker2(
          config: config,
          initialValue: _singleDatePickerValueWithDefaultValue,
          onValueChanged: (values) =>
              setState(() => _singleDatePickerValueWithDefaultValue = values),
        ),
        const SizedBox(height: 10),
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     const Text('Selection(s):  '),
        //     const SizedBox(width: 10),
        //     Text(
        //       _getValueText(
        //         config.calendarType,
        //         _singleDatePickerValueWithDefaultValue,
        //       ),
        //     ),
        //
        //   ],
        // ),
        const SizedBox(height: 25),


        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Container(
        //       decoration: BoxDecoration(
        //         color: AppColor.themeColor,
        //         borderRadius: const BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
        //       ),
        //       height: 60,
        //       width: Get.width/3,
        //       child: CupertinoPicker(
        //         // scrollController: controllr,
        //         diameterRatio: 1.5,
        //         offAxisFraction: 0.2, //轴偏离系数
        //         useMagnifier: true, //使用放大镜
        //         // magnification: 1.5, //当前选中item放大倍数
        //         itemExtent: 45, //行高
        //         backgroundColor: Colors.transparent, //选中器背景色
        //         selectionOverlay: Container(
        //           color: Colors.transparent,
        //         ),
        //         onSelectedItemChanged: (value) {
        //           log("value = $value, 值：${pickerChildren[value]}");
        //         },
        //         children: pickerChildren.map((data) {
        //           return Center(
        //             child: Text(data,style: const TextStyle(color: Colors.white),),
        //           );
        //         }).toList(),
        //       ),
        //     ),
        //     Row(
        //       children: [
        //         Container(
        //           decoration: BoxDecoration(
        //             color: AppColor.themeColor,
        //             borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
        //           ),
        //           height: 60,
        //           width: 120,
        //           child: CupertinoPicker(
        //             // scrollController: controllr,
        //             diameterRatio: 1.5,
        //             offAxisFraction: 0.2, //轴偏离系数
        //             useMagnifier: true, //使用放大镜
        //             // magnification: 1.5, //当前选中item放大倍数
        //             itemExtent: 45, //行高
        //             backgroundColor: Colors.transparent, //选中器背景色
        //             selectionOverlay: Container(
        //               color: Colors.transparent,
        //             ),
        //             onSelectedItemChanged: (value) {
        //               print("value = $value,");
        //             },
        //             children: timePickerChildren.map((data) {
        //               return Center(
        //                 child: Text(data,style: const TextStyle(color: Colors.white),),
        //               );
        //             }).toList(),
        //           ),
        //         ),
        //         Container(
        //           color: AppColor.themeColor,
        //           height: 60,
        //           width: 120,
        //           child: CupertinoPicker(
        //             // scrollController: controllr,
        //             diameterRatio: 1.5,
        //             offAxisFraction: 0.2, //轴偏离系数
        //             useMagnifier: true, //使用放大镜
        //             // magnification: 1.5, //当前选中item放大倍数
        //             itemExtent: 45, //行高
        //             backgroundColor: Colors.transparent, //选中器背景色
        //             selectionOverlay: Container(
        //               color: Colors.transparent,
        //             ),
        //             onSelectedItemChanged: (value) {
        //               print("value = $value,");
        //             },
        //             children: timePickerChildren.map((data) {
        //               return Center(
        //                 child: Text(data,style: const TextStyle(color: Colors.white),),
        //               );
        //             }).toList(),
        //           ),
        //         ),
        //       ],
        //     ),
        //
        //   ],
        // ),
        GestureDetector(
          onTap: (){
            var timeFormat = DateFormat("yyyy-MM-dd");
            var timeStr = timeFormat.format(_singleDatePickerValueWithDefaultValue[0]!);
            print(timeStr);
            Get.back(result: '${timeStr}');
          },
          child:Center(
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              width: Get.width - 50,
              height: 45,
              child:  GradientButton(
                borderRadius: const BorderRadius.all(Radius.circular(20)),colors: [
                AppColor.themeColor,
                AppColor.themeColor,
              ],
                child: Text('确定'),),
            ),
          ),
        )
      ],
    );
  }
  List pickerChildren = [
    "上午",
    "下午",
  ];

  List timePickerChildren = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
  ];

  int selectedValue = 0;

  String _getValueText(
      CalendarDatePicker2Type datePickerType,
      List<DateTime?> values,
      ) {
    // var valueText = (values.isNotEmpty ? values[0] : null)
    //     .toString()
    //     .replaceAll('00:00:00.000', '');

    var timeFormat = DateFormat("yyyy-MM-dd");
    var valueText = timeFormat.format(values[0]!);

    return valueText;
  }
}
