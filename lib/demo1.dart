import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


class Demo1 extends StatefulWidget {
  const Demo1({Key? key}) : super(key: key);

  @override
  State<Demo1> createState() => _Demo1State();
}

class _Demo1State extends State<Demo1> with SingleTickerProviderStateMixin{

  final List<String> _tabs = <String>['最新文章', '我的关注'];

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: EasyRefresh.custom(
        slivers: [
          // _buildAppbar(),
          _buildBox1(),
          _buildBox(),
          // _buildBox2(),
          // _buildTabView(),
          

          SliverList(delegate: _mySliverChildBuilderDelegate())
        ],
      ),
    );
  }

  Widget _buildTabView(){
    return TabBar(tabs: _tabs.map((String name) => Tab(text: name)).toList(),);
  }

  Widget _buildBox() {
    // TODO 构建可吸顶的块
    return SliverPersistentHeader(
      pinned: true,
      // floating: true,
      delegate: FixedPersistentHeaderDelegate(height: 54),
    );
  }

  Widget _buildBox1() {
    return SliverPersistentHeader(
      floating: true,
      delegate: FixedPersistentHeaderDelegate(height: 60),
    );
  }

  Widget _buildBox2(){
    return SliverPersistentHeader(
      delegate: AffHeader(100),
      pinned: true,
    );
  }

  Widget _buildAppbar() {
    return SliverAppBar(
      expandedHeight: 300,
      title: const Text('CustomScrollView 测试'),
      flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: Image.asset(
              'images/class_room_bg.png',
              fit: BoxFit.fill)
      ),
      pinned: true,
      // snap: true,
      // floating: true,
    );
  }

  SliverChildBuilderDelegate _mySliverChildBuilderDelegate(){
    return SliverChildBuilderDelegate((context, index) {
      return Container(
        margin: EdgeInsets.all(15),
        height: 50,
        color: Colors.blue.withOpacity((index % 10) * 0.1),
        child: Text('${index}'),
      );
    },childCount: 15);
  }

}

class AffHeader extends SliverPersistentHeaderDelegate{


  final double height;

  AffHeader(this.height);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      height: height,
      color:Colors.blue,
      child: Text('AFFHeader'),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => height;

  @override
  // TODO: implement minExtent
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant AffHeader oldDelegate) {
    // TODO: implement shouldRebuild
    return oldDelegate.height != height;
  }
  
}


class FixedPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;

  FixedPersistentHeaderDelegate({required this.height});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: height,
      alignment: Alignment.center,
      color: Colors.red,
      child: Text(
        'FixedPersistentHeader',
        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant FixedPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.height != height;
  }
}

class ShowOnScreenSPHD extends SliverPersistentHeaderDelegate {
  final double height;

  ShowOnScreenSPHD({required this.height});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: height,
      alignment: Alignment.center,
      color: Colors.orange,
      child: Text( 'ShowOnScreenSPHD',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant ShowOnScreenSPHD oldDelegate) {
    return oldDelegate.height != height;
  }

  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration {
    return PersistentHeaderShowOnScreenConfiguration(
      minShowOnScreenExtent: double.infinity,
    );
  }
}