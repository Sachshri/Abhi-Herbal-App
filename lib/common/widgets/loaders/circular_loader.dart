import 'package:flutter/material.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';

class CustomCircularLoader extends StatelessWidget {
  final double size;
  final Color color;

  const CustomCircularLoader({
    super.key,
    this.size = 50.0,
    this.color = ColorConstants.primary, // Default color similar to your image
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.1), 
          shape: BoxShape.circle,
        ),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: 4.0,
          ),
        ),
      ),
    );
  }
}
