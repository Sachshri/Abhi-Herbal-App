import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';

class CommonSpacingStyle {
  CommonSpacingStyle._();
  static const EdgeInsets paddingWithAppHeight = EdgeInsets.only(
    left: SizeConstants.defaultSpace,
    right: SizeConstants.defaultSpace,
    top: SizeConstants.appBarHeight,
  );
}
