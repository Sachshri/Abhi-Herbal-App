import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/loaders/animation_loader.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import '../helpers/helper_functions.dart';

/// A utility class for managing a full-screen loading dialog.
class CustomFullScreenLoader {
  /// Open a full-screen loading dialog with a given text and animation.
  /// This method doesn't return anything.
  ///
  /// Parameters:
  /// - `text`: The text to be displayed in the loading dialog.
  /// - `animation`: The Lottie animation to be shown.
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!, // Use GetX overlay context
      barrierDismissible:
          false, // The dialog can't be dismissed by tapping outside
      builder:
          (_) => PopScope(
            canPop: false, // Disable popping with the back button
            child: Container(
              color:
                  HelperFunctions.isDarkMode(Get.context!)
                      ? ColorConstants.dark
                      : ColorConstants.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // const SizedBox(height: 250), // Adjust spacing
                  CustomAnimationLoader(text: text, animation: animation),
                ],
              ),
            ),
          ),
    );
  }

  /// Close the currently open loading dialog
  static void closeLoadingDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
