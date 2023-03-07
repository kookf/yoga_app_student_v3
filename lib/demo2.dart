import 'dart:io';

import 'package:flutter/material.dart';

class Dome2 extends StatefulWidget {
  const Dome2({Key? key}) : super(key: key);

  @override
  State<Dome2> createState() => _Dome2State();
}

class _Dome2State extends State<Dome2> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doTask1();
    doTask2();
    doTask3();
  }


  void doTask1(){
    print('扫地');
  }
  void doTask2()async{
    File file = File('/Users/mozhu/Desktop/Amos_Demo/__manifest__.py');
    print('开始读取');
    String s = await file.readAsString();

  }
  void doTask3(){
    print('做饭');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

      ),
    );
  }


  List<Widget> _buildHeader(BuildContext context,bool innerBoxIsScrolled){
    return [
      Text('data'),
    ];
  }



}
