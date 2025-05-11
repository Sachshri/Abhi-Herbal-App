import 'package:flutter/material.dart';

class CustomCircularContainer extends StatelessWidget {
  const CustomCircularContainer({
    super.key,
    this.color,
    this.radius = 50,
    this.child,
    this.height,
    this.width,
    this.margin,
    this.padding,
  });
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        color: color,
      ),
      child: child,
    );
  }
}
