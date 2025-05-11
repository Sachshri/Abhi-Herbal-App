import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/features/shop/models/category_model.dart';
import 'package:new_flutter_app/utils/exceptions/custom_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  //Fucntion to fetch user details based on user id
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final documentSnapshot =
          await _db
              .collection('Categories')
              .get();
      final list=documentSnapshot.docs.map((e)=> CategoryModel.fromSnapshot(e)).toList();
      return list;
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

  Future<List<CategoryModel>>getSubCategories(String categoryId)async {
        try {
      final documentSnapshot =
          await _db
              .collection('Categories').where('ParentId',isEqualTo: categoryId)
              .get();
      final list=documentSnapshot.docs.map((e)=> CategoryModel.fromSnapshot(e)).toList();
      return list;
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

  //
}
