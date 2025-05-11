import 'package:new_flutter_app/utils/device/device_utility.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.actions,
  });

  final Widget? title;
  final Icon? leadingIcon;
  final VoidCallback? leadingOnPressed;
  final bool showBackArrow;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      leading:
          showBackArrow
              ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Get.back(),
                color:
                    HelperFunctions.isDarkMode(context)
                        ? Colors.white
                        : Colors.black,
              )
              : leadingOnPressed != null
              ? IconButton(
                icon: leadingIcon!,
                onPressed: () => leadingOnPressed,
              )
              : null,
      automaticallyImplyLeading: showBackArrow,
      actions: actions,
      title: title,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(DeviceUtility.getAppBarHeight());
}
