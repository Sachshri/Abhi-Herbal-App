import 'package:flutter/material.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerEffect extends StatelessWidget {
  const CustomShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color,
  });

  final double width, height, radius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark? Colors.grey[850]!: Colors.grey[300]!,
      highlightColor: dark? Colors.grey[700]!: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: dark? ColorConstants.darkerGrey: ColorConstants.white,
          borderRadius: BorderRadius.circular(radius),
        ),
        ),
    );
  }
}
