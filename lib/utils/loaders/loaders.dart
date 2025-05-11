import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';

class   CustomLoaders{
  static hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: HelperFunctions.isDarkMode(Get.context!) 
              ? const Color.fromARGB(229, 79, 79, 79)
              : const Color.fromARGB(228, 224, 224, 224),
          ),
          child: Center(
            child: Text(
              message, 
              style: Theme.of(Get.context!).textTheme.labelLarge,
            ),
          ),
        ),
    ),
  );
}


  static errorSnackBar({required title,message="",duration=3}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: duration),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      isDismissible: true,
      shouldIconPulse: true,
      icon: Icon(Iconsax.close_circle,color: ColorConstants.white,),
    );
  }
  static successSnackBar({required title,message="",duration=3}){
    Get.snackbar(
      title,
      message,
      backgroundColor: ColorConstants.primary,
      colorText: Colors.white,
      duration: Duration(seconds: duration),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      isDismissible: true,
      shouldIconPulse: true,
      icon: Icon(Icons.check,color: ColorConstants.white,),
    );
  }
  static warningSnackBar({required title,message="",duration=3}){
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: Duration(seconds: duration),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      isDismissible: true,
      shouldIconPulse: true,
      icon: Icon(Iconsax.warning_2,color: ColorConstants.white,),
    );
  }

}