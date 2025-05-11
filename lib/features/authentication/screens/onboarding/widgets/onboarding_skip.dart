import 'package:new_flutter_app/features/authentication/controllers/onboardiing/onboarding_controller.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    return Positioned(
      top: DeviceUtility.getAppBarHeight(),
      right: SizeConstants.defaultSpace,
      child: TextButton(onPressed: controller.skipPage, child: Text("Skip")),
    );
  }
}
