import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/// 质感设计Footer
class MaterialFooter1 extends Footer {
  final Key? key;

  /// 颜色
  final Animation<Color?>? valueColor;

  /// 背景颜色
  final Color? backgroundColor;

  final LinkFooterNotifier linkNotifier = LinkFooterNotifier();

  MaterialFooter1({
    this.key,
    this.valueColor,
    this.backgroundColor,
    completeDuration = const Duration(seconds: 1),
    bool enableHapticFeedback = false,
    bool enableInfiniteLoad = true,
    bool overScroll = false,
  }) : super(
    float: true,
    extent: 72.0,
    triggerDistance: 72.0,
    completeDuration: completeDuration == null
        ? Duration(
      milliseconds: 300,
    )
        : completeDuration +
        Duration(
          milliseconds: 300,
        ),
    enableHapticFeedback: enableHapticFeedback,
    enableInfiniteLoad: enableInfiniteLoad,
    overScroll: overScroll,
  );

  @override
  Widget contentBuilder(
      BuildContext context,
      LoadMode loadState,
      double pulledExtent,
      double loadTriggerPullDistance,
      double loadIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration? completeDuration,
      bool enableInfiniteLoad,
      bool success,
      bool noMore) {
    linkNotifier.contentBuilder(
        context,
        loadState,
        pulledExtent,
        loadTriggerPullDistance,
        loadIndicatorExtent,
        axisDirection,
        float,
        completeDuration,
        enableInfiniteLoad,
        success,
        noMore);
    return MaterialFooterWidget(
      key: key,
      valueColor: valueColor,
      backgroundColor: backgroundColor,
      linkNotifier: linkNotifier,
    );
  }
}

/// 质感设计Footer组件
class MaterialFooterWidget extends StatefulWidget {
  // 颜色
  final Animation<Color?>? valueColor;

  // 背景颜色
  final Color? backgroundColor;
  final LinkFooterNotifier linkNotifier;

  const MaterialFooterWidget({
    Key? key,
    this.valueColor,
    this.backgroundColor,
    required this.linkNotifier,
  }) : super(key: key);

  @override
  MaterialFooterWidgetState createState() {
    return MaterialFooterWidgetState();
  }
}

class MaterialFooterWidgetState extends State<MaterialFooterWidget> {
  LoadMode get _refreshState => widget.linkNotifier.loadState;

  double get _pulledExtent => widget.linkNotifier.pulledExtent;

  double get _riggerPullDistance => widget.linkNotifier.loadTriggerPullDistance;

  AxisDirection get _axisDirection => widget.linkNotifier.axisDirection;

  bool get _noMore => widget.linkNotifier.noMore;

  @override
  Widget build(BuildContext context) {
    if (_noMore) return  Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      alignment: Alignment.center,

      margin: EdgeInsets.only(bottom: 0),
      // color: Colors.yellow,
      child: Text('我是有底线的~',style: TextStyle(fontSize: 13),),
    );
    // 是否为垂直方向
    bool isVertical = _axisDirection == AxisDirection.down ||
        _axisDirection == AxisDirection.up;
    // 是否反向
    bool isReverse = _axisDirection == AxisDirection.up ||
        _axisDirection == AxisDirection.left;
    // 计算进度值
    double indicatorValue = _pulledExtent / _riggerPullDistance;
    indicatorValue = indicatorValue < 1.0 ? indicatorValue : 1.0;
    return Stack(
      children: <Widget>[
        Positioned(
          top: isVertical
              ? !isReverse
              ? 0.0
              : null
              : 0.0,
          bottom: isVertical
              ? isReverse
              ? 0.0
              : null
              : 0.0,
          left: !isVertical
              ? !isReverse
              ? 0.0
              : null
              : 0.0,
          right: !isVertical
              ? isReverse
              ? 0.0
              : null
              : 0.0,
          child: Container(
            alignment: isVertical
                ? !isReverse
                ? Alignment.topCenter
                : Alignment.bottomCenter
                : !isReverse
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: RefreshProgressIndicator(
              value: _refreshState == LoadMode.armed ||
                  _refreshState == LoadMode.load ||
                  _refreshState == LoadMode.loaded ||
                  _refreshState == LoadMode.done
                  ? null
                  : indicatorValue,
              valueColor: widget.valueColor,
              backgroundColor: widget.backgroundColor,
            ),
          ),
        ),
      ],
    );
  }
}
