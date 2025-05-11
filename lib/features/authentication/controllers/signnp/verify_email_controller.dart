import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/success_screen/success_screen.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';

class VerifyEmailController extends GetxController {
  //Send email when verify email screen appear & set timer for autoredirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  //Send Email Verification mail
  Future<void> sendEmailVerification() async {
    try {
      //Send Email Verification
      await AuthenticationRepository.instance.sendEmailVerification();
      CustomLoaders.successSnackBar(
        title: 'Success',
        message:
            'Verification email sent successfully.Check your inbox or spam folder and verify your email.',
      );
    } catch (e) {
      //Error
      CustomLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  //Timer to automatically redirect to Verification Screen
  void setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      //Check if email is verified
      if (user?.emailVerified ?? false) {
        //Email is verified
        timer.cancel();
        Get.offAll(
          () => SuccessScreen(
            image: ImageStringsConstants.successImage,
            title: TextStringsConstants.yourAccountCreatedTitle,
            subtitle: TextStringsConstants.yourAccountCreatedSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
            actionName: 'Continue',
          ),
        );
      }
    },
    );
  }

  // Manually check if email is verify
  checkEmailVerificationStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user!= null && user.emailVerified) {
      Get.offAll(
        () => SuccessScreen(
          image: ImageStringsConstants.successImage,
          title: TextStringsConstants.yourAccountCreatedTitle,
          subtitle: TextStringsConstants.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          actionName: 'Continue',
        ),
      );
    }
  }
}
