import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/data/repositories/users/user_repository.dart';
import 'package:new_flutter_app/features/authentication/screens/login/login_screen.dart';
import 'package:new_flutter_app/features/personalization/models/user_model.dart';
import 'package:new_flutter_app/features/personalization/screens/profile/reauthenticate_user_login_form.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/network_manager.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';
import 'package:new_flutter_app/utils/popups/full_screen_loader.dart';

import '../screens/profile/profile_screen.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  //Fetch User Details

  Future<void> fetchUserDetails() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Save User Record from any Registration Provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      await fetchUserDetails();

      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert name to First and last Name
          final nameParts = UserModel.nameParts(
            userCredentials.user!.displayName ?? '',
          );
          final username = UserModel.generateUsername(
            userCredentials.user!.displayName ?? '',
          );
          // Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join() : '',
            email: userCredentials.user!.email ?? "",
            username: username,
            phoneNumber: userCredentials.user!.phoneNumber ?? "",
            profilePicture: userCredentials.user!.photoURL ?? '',
            role: 'user',
          );

          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      CustomLoaders.warningSnackBar(
        title: 'Data Not Saved',
        message:
            "Something went wrong while saving your information. You can re-save your data in your Profile.",
      );
    }
  }

  //Delete Account Warning Popup
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(SizeConstants.md),
      title: "Delete Account",
      middleText:
          "Are you sure you want to delete your account permanently? This action is not  ",
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConstants.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: Text("Cancel"),
      ),
    );
  }

  //Delete User Account
  void deleteUserAccount() async {
    try {
      CustomFullScreenLoader.openLoadingDialog(
        "Deleting Your Account...",
        'assets/animations/loading.gif',
      );
      //First re-authenticate User
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        //Re verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          CustomFullScreenLoader.closeLoadingDialog();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          CustomFullScreenLoader.closeLoadingDialog();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      CustomFullScreenLoader.closeLoadingDialog();
      CustomLoaders.warningSnackBar(
        title: 'Something Went Wrong',
        message: e.toString(),
      );
    }
  }

  // Re Authenticate before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      CustomFullScreenLoader.openLoadingDialog(
        "Processing..",
        'assets/animations/login.gif',
      );

      //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullScreenLoader.closeLoadingDialog();
        return;
      }
      if (!reAuthFormKey.currentState!.validate()) {
        CustomFullScreenLoader.closeLoadingDialog();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
            verifyEmail.text.trim(),
            verifyPassword.text.trim(),
          );

      await AuthenticationRepository.instance.deleteAccount();
      CustomFullScreenLoader.closeLoadingDialog();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      CustomFullScreenLoader.closeLoadingDialog();
      CustomLoaders.warningSnackBar(
        title: "Something Went Wrong!",
        message: e.toString(),
      );
    }
  }

  // Update use profile picture
  Future<void> updateUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        // final imageUrl=await  userRepository.uploadImage( 'Users/Images/Profile/',image);
        final imageUrl = await userRepository.uploadImage(
          image,
          "Users/Images/Profile",
          'abhi_herbal_upload',
        );

        // Check Internet Connectivity
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          CustomFullScreenLoader.closeLoadingDialog();
          CustomLoaders.customToast(
            message: "Please Check your internet connection.",
          );
          return;
        }
        // Update user profile picture
        Map<String, dynamic> json = {};
        json['profilePicture'] = imageUrl;
        await UserRepository.instance.updateSingleField(json);
        // Update the Rx User Value
        user.value.profilePicture = imageUrl;
        CustomLoaders.successSnackBar(
          title: "Profile Updated!",
          message: "Your Profile Picture has been updated.",
        );
        Get.off(() => const ProfileScreen());
      }
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: "Something Went wrong",
        message: e.toString(),
      );
    }
  }
}
