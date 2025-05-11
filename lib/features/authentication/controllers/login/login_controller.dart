import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/features/personalization/controllers/user_controller.dart';
import 'package:new_flutter_app/utils/helpers/network_manager.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';
import 'package:new_flutter_app/utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Rx<bool> hidePassword = true.obs;
  Rx<bool> rememberMe = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController(); // Controller for email
  final password = TextEditingController(); // Controller for password
  final userController = Get.put(UserController());
  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  //login In(Email and Password)
  Future<void> login() async {
    try {
      CustomFullScreenLoader.openLoadingDialog(
        "Logging You In...",
        'assets/animations/login.gif',
      );

      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // No internet connection
        CustomFullScreenLoader.closeLoadingDialog();
        CustomLoaders.customToast(
          message: 'Please connect to the network',
        );
        return;
      }
      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        CustomFullScreenLoader.closeLoadingDialog();
        return;
      }
      //Save the data in local storage if rememberMe is true
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      // Logging in the use
      await AuthenticationRepository.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );
      //Removing Loader
      CustomFullScreenLoader.closeLoadingDialog();

      //Show Success Message
      CustomLoaders.successSnackBar(
        title: "Great to see you!",
        message:
            "Small steps today lead to a stronger, healthier tomorrow. Let's thrive together! 💪🍏",
      );
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Sign up failed or any error
      CustomFullScreenLoader.closeLoadingDialog();
      CustomLoaders.errorSnackBar(title: 'Login Failed', message: e.toString());
    }
  }

  // Goolge Sign in Authentiation
  Future<void> googleSignIn() async {
    try {
      CustomFullScreenLoader.openLoadingDialog(
        'Loggin You In...',
        'assets/animations/login.gif',
      );
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullScreenLoader.closeLoadingDialog();
        return;
      }
      //Google Authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      //Save user Record
      await userController.saveUserRecord(userCredentials);
      CustomFullScreenLoader.closeLoadingDialog();
      //go to main page

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      CustomFullScreenLoader.closeLoadingDialog();
      CustomLoaders.errorSnackBar(
        title: 'Something went wrong!',
        message: e.toString(),
      );
    }
  }

  void toggleVisibility() {
    hidePassword.value = !hidePassword.value;
  }
}
