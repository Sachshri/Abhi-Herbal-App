import 'package:new_flutter_app/common/widgets/image_widgets/custom_circular_image.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';

class CustomVerticalImageText extends StatelessWidget {
  const CustomVerticalImageText({
    super.key,
    required this.imageUrl,
    required this.title,
    this.isNetworkImage = false,
    this.onTap,
    this.backgroundColor,
  });
  final String imageUrl;
  final String title;
  final bool isNetworkImage;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: SizeConstants.md),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            CustomCircularImage(
              image: imageUrl,
              fit: BoxFit.fitWidth,
              padding: SizeConstants.sm * 1.4,
              isNetworkImage: true,
              overlayColor:
                  HelperFunctions.isDarkMode(context)
                      ? ColorConstants.darkGrey
                      : ColorConstants.darkerGrey,
              backgroundColor: backgroundColor,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.apply(color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
