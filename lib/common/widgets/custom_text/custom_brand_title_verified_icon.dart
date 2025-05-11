import 'package:new_flutter_app/common/widgets/custom_text/custom_brand_text.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/enums.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomBrandTitleWithVerfiedIcon extends StatelessWidget {
  const CustomBrandTitleWithVerfiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor,
    this.textAlign,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: CustomBrandTitleText(
            title: title,
            color: textColor,
            maxLines: 1,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ),
        ),
        const SizedBox(width: SizeConstants.xs),
        const Icon(
          Iconsax.verify5,
          color: ColorConstants.primary,
          size: SizeConstants.iconXs,
        ),
      ],
    );
  }
}
