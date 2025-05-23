import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/features/shop/models/banner_model.dart';
import 'package:new_flutter_app/utils/exceptions/custom_exceptions.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();
  //Variables
  final _db = FirebaseFirestore.instance;
  //Get all orders related to current user
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result =
          await _db
              .collection('Banners')
              .where('Active', isEqualTo: true)
              .get();
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    }
  }

  // Upload Banners to Cloud Firebase
}
