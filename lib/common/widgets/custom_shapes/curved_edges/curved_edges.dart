import 'package:flutter/material.dart';

class CurverEdgesClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0, size.height);
    //first curve
    final firstCurveStartOffset = Offset(0, size.height-20);
    final firstCurveEndOffset = Offset(30, size.height - 20);
    path.quadraticBezierTo(firstCurveStartOffset.dx, firstCurveStartOffset.dy,firstCurveEndOffset.dx, firstCurveEndOffset.dy);
    //second curve
    final secondCurveStartOffset = Offset(0, size.height - 20);
    final secondCurveEndOffset = Offset(size.width-30, size.height - 20);
    path.quadraticBezierTo(secondCurveStartOffset.dx, secondCurveStartOffset.dy,secondCurveEndOffset.dx, secondCurveEndOffset.dy);
    //third curve
    final thirdCurveStartOffset = Offset(size.width, size.height - 20);
    final thirdCurveEndOffset = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdCurveStartOffset.dx, thirdCurveStartOffset.dy,thirdCurveEndOffset.dx, thirdCurveEndOffset.dy);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw true;
  }
}
