import 'package:flutter/material.dart';

import '../common/colors.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    this.colors,
    this.width,
    this.height,
    this.onPressed,
    this.borderRadius,
    required this.child,
  }) : super(key: key);

  // 渐变色数组
  final List<Color>? colors;

  // 按钮宽高
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  //点击回调
  final GestureTapCallback? onPressed;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    //确保colors数组不空
    List<Color> colors1 = colors ??
        [
          AppColor.registerBgColor,
          AppColor.themeColor,
        ];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors1),
        borderRadius: borderRadius,
        //border: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: colors1.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
