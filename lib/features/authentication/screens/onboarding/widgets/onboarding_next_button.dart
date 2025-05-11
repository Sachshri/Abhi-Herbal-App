import 'package:new_flutter_app/features/authentication/controllers/onboardiing/onboarding_controller.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/device/device_utility.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    bool dark = !HelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: DeviceUtility.getBottomNavigationBarHeight(),
      right: SizeConstants.defaultSpace,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? Colors.black : ColorConstants.primary,
        ),
        onPressed: controller.nextPage,
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
