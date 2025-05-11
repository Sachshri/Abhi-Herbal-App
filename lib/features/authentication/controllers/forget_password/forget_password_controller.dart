import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/features/authentication/screens/password_recovery/reset_password_screen.dart';
import 'package:new_flutter_app/utils/helpers/network_manager.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';
import 'package:new_flutter_app/utils/popups/full_screen_loader.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Send Reset Password Email
  Future<void> sendPasswordResetEmail() async {
    try {
      CustomFullScreenLoader.openLoadingDialog(
        "Processing Your Request...",
        'assets/animations/login.gif',
      );

      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // No internet connection
        CustomFullScreenLoader.closeLoadingDialog();
        return;
      }
      // Form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        CustomFullScreenLoader.closeLoadingDialog();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      );
      //Remove loader
      CustomFullScreenLoader.closeLoadingDialog();
      //SHow success Screen
      CustomLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Email Link Sent to Reset your Password'.tr,
      );
      //Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      CustomFullScreenLoader.closeLoadingDialog();
      CustomLoaders.errorSnackBar(
        title: "Something Went Wrong",
        message: e.toString(),
      );
    }
  }

  Future<void> resendPasswordResetEmail(String email) async {
    try {
      CustomFullScreenLoader.openLoadingDialog(
        "Processing Your Request...",
        'assets/animations/login.gif',
      );

      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // No internet connection
        CustomFullScreenLoader.closeLoadingDialog();
        return;
      }

      //Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(
        email,
      );
      //Remove loader
      CustomFullScreenLoader.closeLoadingDialog();
      //SHow success Screen
      CustomLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Email Link Sent to Reset your Password'.tr,
      );
    } catch (e) {
      CustomFullScreenLoader.closeLoadingDialog();
      CustomLoaders.errorSnackBar(
        title: "Something Went Wrong",
        message: e.toString(),
      );
    }
  }
}
