import 'package:new_flutter_app/features/authentication/controllers/onboardiing/onboarding_controller.dart';
import 'package:new_flutter_app/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:new_flutter_app/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:new_flutter_app/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:new_flutter_app/features/authentication/screens/onboarding/widgets/onboarding_smooth_dot_navigation.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          //Onboarding Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: ImageStringsConstants.onBoardingImage1,
                title: TextStringsConstants.onBoardingTitle1,
                subTitle: TextStringsConstants.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: ImageStringsConstants.onBoardingImage2,
                title: TextStringsConstants.onBoardingTitle2,
                subTitle: TextStringsConstants.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: ImageStringsConstants.onBoardingImage3,
                title: TextStringsConstants.onBoardingTitle3,
                subTitle: TextStringsConstants.onBoardingSubTitle3,
              ),
            ],
          ),
          //Skip Text
          const OnBoardingSkip(),
          //Dot Navigation SmmothPageIndicator
          const OnBoardingDotNavigation(),
          //Circular Static Button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
