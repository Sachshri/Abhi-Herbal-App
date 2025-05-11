import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_flutter_app/utils/exceptions/custom_exceptions.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/features/personalization/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to save user data
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  //Fucntion to fetch user details based on user id
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot =
          await _db
              .collection('Users')
              .doc(AuthenticationRepository.instance.authUser?.uid)
              .get();
      if (documentSnapshot.exists) {
        //"User Data: ${documentSnapshot.data()}");
        return UserModel.fromMap(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  //Function to update user data in firestore
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  //Function to update user single field data in firestore
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  //Function to remove user single field data in firestore
  //Function to remove user data in firestore
  Future<void> removeUserData(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// Upload any image
  // Future<String> uploadImage(String path, XFile image) async {
  //   try {
  //     final ref = FirebaseStorage.instance.ref(path).child(image.name);
  //     await ref.putFile(File(image.path));
  //     final url = await ref.getDownloadURL();
  //     return url;
  //   } on FirebaseException catch (e) {
  //     throw CustomFirebaseAuthException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const CustomFormatException();
  //   } on PlatformException catch (e) {
  //     throw CustomPlatformException(e.code).message;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
  Future<String> uploadImage(
    XFile image,
    String cloudFolder,
    String presetName,
  ) async {
    String cloudinaryCloudName =
        dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? 'NO NAME AVAILABLE';
    final cloudinaryUrl =
        "https://api.cloudinary.com/v1_1/$cloudinaryCloudName/image/upload";

    try {
      var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));

      if (kIsWeb) {
        // Flutter Web: Read file as bytes
        Uint8List imageBytes = await image.readAsBytes();
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            imageBytes,
            filename: image.name,
          ),
        );
      } else {
        // Android/iOS: Use fromPath
        request.files.add(
          await http.MultipartFile.fromPath('file', image.path),
        );
      }

      // Add Cloudinary upload preset
      // request.fields['upload_preset'] = "abhi_herbal_upload"; // Use your preset name
      request.fields['upload_preset'] = presetName; // Use your preset name

      // Store image in "Users/Images/Profile" folder
      request.fields['folder'] = cloudFolder;
      // request.fields['folder'] = "Users/Images/Profile";

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData);

      if (response.statusCode == 200) {
        return jsonData["secure_url"]; //  Cloudinary URL of uploaded image
      } else {
        throw "Cloudinary upload failed: ${jsonData['error']['message']}";
      }
    } catch (e) {
      throw "Image upload failed: $e";
    }
  }
  // Future<String> uploadImage(XFile image) async {
  //   final cloudinaryUrl = "https://api.cloudinary.com/v1_1/ddfafeujh/image/upload";
  //   final signatureUrl = "https://your-backend.com/generate-signature"; // Your backend API

  //   try {
  //     // 🔹 1. Get the signature from the backend
  //     final signatureResponse = await http.post(Uri.parse(signatureUrl));
  //     if (signatureResponse.statusCode != 200) throw "Failed to get signature";

  //     final signatureData = jsonDecode(signatureResponse.body);
  //     final String signature = signatureData["signature"];
  //     final String apiKey = signatureData["api_key"];
  //     final int timestamp = signatureData["timestamp"];

  //     // 🔹 2. Upload image to Cloudinary with signed request
  //     var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));

  //     // Attach image file
  //     request.files.add(await http.MultipartFile.fromPath('file', image.path));

  //     // Required signed parameters
  //     request.fields['api_key'] = apiKey;
  //     request.fields['timestamp'] = timestamp.toString();
  //     request.fields['signature'] = signature;
  //     request.fields['upload_preset'] = "abhi_herbal_upload";

  //     // 🔹 Store images inside "Users/Images/Profile" folder
  //     request.fields['folder'] = "Users/Images/Profile";

  //     var response = await request.send();
  //     var responseData = await response.stream.bytesToString();
  //     var jsonData = jsonDecode(responseData);

  //     if (response.statusCode == 200) {
  //       return jsonData["secure_url"]; // ✅ Cloudinary URL of uploaded image
  //     } else {
  //       throw Exception("Cloudinary upload failed: ${jsonData['error']['message']}");
  //     }
  //   } catch (e) {
  //     throw Exception("Image upload failed: $e");
  //   }
  // }
}
