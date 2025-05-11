import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/device/device_utility.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.icon,
    this.onTap,
    required this.hintText,
    this.showBackground = true,
    this.showBorder = true,
    this.padding,
    this.hintTextColor = const Color.fromARGB(255, 147, 147, 147),
    this.backgroundColor = const Color.fromARGB(150, 255, 255, 255),
  });
  final IconData? icon;
  final VoidCallback? onTap;
  final String hintText;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry? padding;
  final Color hintTextColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding!,
        child: Container(
          width: DeviceUtility.getScreenWidth(context),
          padding: EdgeInsets.all(SizeConstants.md),
          decoration: BoxDecoration(
            color: showBackground ? backgroundColor : Colors.transparent,
            borderRadius: BorderRadius.circular(SizeConstants.cardRadiusLg),
            border: showBorder ? Border.all(color: ColorConstants.grey) : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: !dark ? ColorConstants.grey : ColorConstants.darkGrey,
              ),
              const SizedBox(width: SizeConstants.md),
              Expanded(
                child: Text(
                  hintText,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall!.apply(color: hintTextColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
