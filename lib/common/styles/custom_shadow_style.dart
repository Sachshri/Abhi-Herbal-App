import 'package:flutter/material.dart';

import '../../utils/constants/color_constants.dart';

class CustomShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: ColorConstants.darkGrey.withAlpha(3),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static final horizontalProductShadow = BoxShadow(
    color: ColorConstants.darkGrey.withAlpha(3),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}
