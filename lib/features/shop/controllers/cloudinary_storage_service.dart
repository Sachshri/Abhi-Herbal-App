import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CustomCloudinaryStorageService extends GetxController {
  static CustomCloudinaryStorageService get instance => Get.find();
  static const String cloudinaryUrl =
      "https://api.cloudinary.com/v1_1/ddfafeujh/image/upload";
  static const String uploadPreset = "abhi_herbal_upload"; 
  static const String folderPath = "Assets/Images/Categories"; 

Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      return byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      );
    } catch (e) {
      throw "Error loading image data: $e";
    }
  }

  /// Upload image to Cloudinary and return the URL
  Future<String> uploadImageData(Uint8List imageBytes, String fileName,{String? folderName}) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
        ..fields['upload_preset'] = uploadPreset
        ..fields['folder'] = folderName ?? folderPath
        ..files.add(
          http.MultipartFile.fromBytes(
            'file',
            imageBytes,
            filename: fileName,
          ),
        );

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData);

      if (response.statusCode == 200) {
        return jsonData["secure_url"]; // ✅ Return Cloudinary URL
      } else {
        throw "Cloudinary upload failed: ${jsonData['error']['message']}";
      }
    } catch (e) {
      throw "Image upload failed: $e";
    }
  }

  //Upload image File
  Future<String> uploadImage(XFile image,String cloudFolder) async {
  try {
    var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));

    if (kIsWeb) {
      // Flutter Web: Read file as bytes
      Uint8List imageBytes = await image.readAsBytes();
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: image.name,
      ));
    } else {
      // Android/iOS: Use fromPath
      request.files.add(await http.MultipartFile.fromPath('file', image.path));
    }

    // Add Cloudinary upload preset
    // request.fields['upload_preset'] = "abhi_herbal_upload"; // Use your preset name
    request.fields['upload_preset'] = uploadPreset; // Use your preset name

    // Store image in "Users/Images/Profile" folder
    request.fields['folder'] = folderPath;
    // request.fields['folder'] = "Users/Images/Profile";

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonData = jsonDecode(responseData);

    if (response.statusCode == 200) {
      return jsonData["secure_url"]; // ✅ Cloudinary URL of uploaded image
    } else {
      throw "Cloudinary upload failed: ${jsonData['error']['message']}";
    }
  } catch (e) {
    throw "Image upload failed: $e";
  }
}           


}
