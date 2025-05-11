import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/data/repositories/users/user_repository.dart';
import 'package:new_flutter_app/features/authentication/screens/signup/verify_email_screen.dart';
import 'package:new_flutter_app/features/personalization/models/user_model.dart';
import 'package:new_flutter_app/utils/helpers/network_manager.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';
import 'package:new_flutter_app/utils/popups/full_screen_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final hidePassword = true.obs; // Hide password
  final privacyPolicy = true.obs; // Hide password
  final email = TextEditingController(); // Controller for email
  final password = TextEditingController(); // Controller for password
  final lastName = TextEditingController(); // Controller for last name
  final username = TextEditingController(); // Controller for username
  final firstName = TextEditingController(); // Controller for first name
  final phoneNumber = TextEditingController(); // Controller for phone number

  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); // FORM KEY FOR FORM VALIDATION

  // Sign up
  Future<void> signUp() async {
    // Sign up logic
    try {
      //Start Loading
      CustomFullScreenLoader.openLoadingDialog(
        'We are proecessing your information...',
        'assets/animations/loading_.gif',
      );
      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // No internet connection
        CustomFullScreenLoader.closeLoadingDialog();
        return;
      }
      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        CustomFullScreenLoader.closeLoadingDialog();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        CustomLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'Please accept the privacy policy.',
        );
        CustomFullScreenLoader.closeLoadingDialog();
        return;
      }

      // Register user in the Firebase Authentication & Save User data in the firestore
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );

      // Save Authenticated User Data in Storage
      final newUser = UserModel(
        id: userCredential.user!.uid,
        email: email.text.trim(),
        username: username.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
        role: 'user'
      );
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //Remove loader
      CustomFullScreenLoader.closeLoadingDialog();

      // Show Succes Message
      CustomLoaders.successSnackBar(
        title: "Congratulations",
        message:'Your Account has been created! Verify your email to continue.',
      );
      // Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim(),));
    } catch (e) {
      // Sign up failed or any error
      CustomFullScreenLoader.closeLoadingDialog();
      CustomLoaders.errorSnackBar(
        title: 'Sign Up Failed',
        message: e.toString(),
      );
    } 
  }
}


