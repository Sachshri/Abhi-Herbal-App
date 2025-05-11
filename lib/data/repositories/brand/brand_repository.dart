import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/features/shop/models/brand_model.dart';
import 'package:new_flutter_app/utils/exceptions/custom_exceptions.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      return snapshot.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again. ${e.toString()}";
    }
  }

  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      QuerySnapshot brandCategoryQuery =
          await _db
              .collection('BrandCategory')
              .where('categoryId', isEqualTo: categoryId)
              .get();
      final List<String> brandIds =
          brandCategoryQuery.docs
              .map((doc) => doc['brandId'] as String)
              .toList();

      final brandsQuery =
          await _db
              .collection('Brands')
              .where(FieldPath.documentId, whereIn: brandIds.isNotEmpty? brandIds:['defalut'])
              .limit(2)
              .get();
      return brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again. ${e.toString()}";
    }
  }
}
