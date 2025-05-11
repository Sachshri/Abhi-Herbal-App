import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/device/device_utility.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({super.key, required this.tabs});
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? ColorConstants.black : ColorConstants.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: ColorConstants.primary,
        unselectedLabelColor: ColorConstants.darkGrey,
        labelColor: dark ? ColorConstants.white : ColorConstants.primary,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(DeviceUtility.getAppBarHeight());
}
