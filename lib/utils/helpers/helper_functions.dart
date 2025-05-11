import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelperFunctions {
  HelperFunctions._();

  //Some other named colors used
  static Color? getColor(String value) {
    if (value == "Green") {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else {
      return null;
    }
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
                child: const Text("OK"),
                onPressed: () => Navigator.of(context).pop())
          ],
        );
      },
    );
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime orderDate) {
    return "${orderDate.day}-${orderDate.month}-${orderDate.year}";
  }

  
}
