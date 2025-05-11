import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/features/shop/controllers/cloudinary_storage_service.dart';
import 'package:new_flutter_app/features/shop/models/article_model.dart';
import 'package:new_flutter_app/utils/exceptions/custom_exceptions.dart';

class ArticleRepository {
  static final _collection =
      FirebaseFirestore.instance.collection('Articles');
  static final _db = FirebaseFirestore.instance;
  static Future<void> createArticle(ArticleModel article) async {
    await _collection.doc(article.id).set(article.toJson());
  }

  Future<List<ArticleModel>> fetchCategoryArticles() async{
      try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information. Try again in few minutes';
      }
         final result =
          await _db.collection('Articles').get();
      if (result.docs.isEmpty) {
        //"No orders found for user: $userId");
        return [];
      }

      return result.docs.map((doc) {
        //"Fetched order: ${doc.data()}"); // Debugging
        return ArticleModel.fromSnapshot(doc);
      }).toList();
      // final snapshot =
      //     await _collection
      //         .where('category', isEqualTo: category)
      //         .orderBy('createdAt', descending: true)
      //         .get();
      // return snapshot.docs
      //     .map((doc) => ArticleModel.fromSnapshot(doc))
      //     .toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again. ${e.toString()}";
    }
  }
  static Future<String> uploadImage(
    XFile image,
    String folder,
    String uploadPreset,
  ) async {
    return await CustomCloudinaryStorageService.instance.uploadImage(
      image,
      folder,
    );
  }
}
