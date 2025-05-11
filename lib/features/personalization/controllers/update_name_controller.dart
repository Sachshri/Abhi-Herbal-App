import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/data/repositories/users/user_repository.dart';
import 'package:new_flutter_app/features/personalization/controllers/user_controller.dart';
import 'package:new_flutter_app/features/personalization/screens/profile/profile_screen.dart';
import 'package:new_flutter_app/utils/helpers/network_manager.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';
import 'package:new_flutter_app/utils/popups/full_screen_loader.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  // vairables
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = UserRepository.instance;
  //INIT user data when home screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  //Update User Name
  Future<void> updateUserName() async {
    try {
      CustomFullScreenLoader.openLoadingDialog(
        'Updating Your Profile',
        'assets/animations/loading_.png',
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
      // Update user first & last name
      Map<String, dynamic> json = {};
      json['firstName'] = firstName.text.trim();
      json['lastName'] = lastName.text.trim();
      await UserRepository.instance.updateSingleField(json);
      // Update the Rx User Value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();
      // Remove Loader
      CustomFullScreenLoader.closeLoadingDialog();

      //Show Success Message
      CustomLoaders.successSnackBar(
        title: "Profile Updated!",
        message: "Your Name has been updated.",
      );
      Get.off(() => const ProfileScreen());
    } catch (e) {
      CustomFullScreenLoader.closeLoadingDialog();
      CustomLoaders.errorSnackBar(
        title: "Something Went wrong",
        message: e.toString(),
      );
    }
  }
}
