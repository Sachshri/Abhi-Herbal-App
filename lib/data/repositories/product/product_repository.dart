import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/features/shop/controllers/cloudinary_storage_service.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/utils/exceptions/custom_exceptions.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Get Limiter fearured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot =
          await _db
              .collection('Products')
              .where('IsFeatured', isEqualTo: true)
              .limit(4)
              .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again. ${e.toString()}";
    }
  }
  Future<void> addProduct(ProductModel product) async {
  try {
    final storage = Get.put(CustomCloudinaryStorageService());
    final firestore = FirebaseFirestore.instance;


    // Upload additional product images if any
    if (product.images != null && product.images!.isNotEmpty) {
      List<String> uploadedImages = [];
      for (var image in product.images!) {
        final imageData = await storage.getImageDataFromAssets(image);
        final imageUrl = await storage.uploadImageData(
          imageData,
          image,
          folderName: 'Products/Images',
        );
        uploadedImages.add(imageUrl);
      }
      product.images = uploadedImages;
    }

    // Optionally upload brand image
    if (product.brand != null && product.brand!.image.isNotEmpty) {
      final brandImageData =
          await storage.getImageDataFromAssets(product.brand!.image);
      final brandImageUrl = await storage.uploadImageData(
        brandImageData,
        product.brand!.image,
        folderName: 'Brands/Images',
      );
      product.brand!.image = brandImageUrl;
    }

    // Generate a new document ID if not present
    final productDoc = firestore.collection('Products').doc();
    product.id = productDoc.id;

    // Upload to Firestore
    await productDoc.set(product.toJson());
  } catch (e) {
    throw e.toString();
  }
}

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot =
          await _db
              .collection('Products')
              .where('IsFeatured', isEqualTo: true)
              .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again. ${e.toString()}";
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList =
          querySnapshot.docs
              .map((doc) => ProductModel.fromQuerySnapshot(doc))
              .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again. ${e.toString()}";
    }
  }

  Future<List<ProductModel>> getFavouriteProduct(
    List<String> productIds,
  ) async {
    try {
      final snapshot =
          await _db
              .collection('Products')
              .where(FieldPath.documentId, whereIn: productIds)
              .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again. ${e.toString()}";
    }
  }

  // Get products related to brands
  Future<List<ProductModel>> getProductsForBrand({
    required String brandId,
    int limit = -1,
  }) async {
    try {
      final querySnapshot =
          limit == -1
              ? await _db
                  .collection('Products')
                  .where('Brand.Id', isEqualTo: brandId)
                  .get()
              : await _db
                  .collection('Products')
                  .where('Brand.Id', isEqualTo: brandId)
                  .limit(limit)
                  .get();

      final List<ProductModel> productList =
          querySnapshot.docs
              .map((doc) => ProductModel.fromQuerySnapshot(doc))
              .toList();

      // if (querySnapshot.docs.isEmpty) {
      //   //"No products found for brand ID: $brandId");
      // } else {
      //   //"Found ${querySnapshot.docs.length} products");
      //   for (var doc in querySnapshot.docs) {
      //     //"Product Data: ${doc.data()}");
      //   }
      // }
      return productList;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again. ${e.toString()}";
    }
  }

  // Upload Dummy data to the cloud firebase

  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      final storage = Get.put(CustomCloudinaryStorageService());

      // Loop through each product
      for (var product in products) {
        final thumbnail = await storage.getImageDataFromAssets(
          product.thumbnail,
        );
        final url = await storage.uploadImageData(
          thumbnail,
          product.thumbnail.toString(),
          folderName: 'Products/Images',
        );
        //"Getting  url : $url");
        product.thumbnail = url;

        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrl = [];
          for (var image in product.images!) {
            final assetImage = await storage.getImageDataFromAssets(image);
            final uploadedUrl = await storage.uploadImageData(
              assetImage,
              image,
              folderName: 'Products/Images', // Consistent folder name
            );
            imageUrl.add(uploadedUrl);
          }
          product.images = imageUrl; // ✅ Assign the uploaded image URLs
        }
      }
    } catch (e) {
      throw e.toString();
      //  ✅ Handle errors properly
    }
  }

  // Get products related to Category
  Future<List<ProductModel>> getProductsForCategory({
    required String categoryId,
    int limit = -1,
  }) async {
    try {
      final productCategoryQuery =
          limit == -1
              ? await _db
                  .collection('ProductCategory')
                  .where('categoryId', isEqualTo: categoryId)
                  .get()
              : await _db
                  .collection('ProductCategory')
                  .where('categoryId', isEqualTo: categoryId)
                  .limit(limit)
                  .get();
      List<String> productIds =
          productCategoryQuery.docs
              .map((doc) => doc['productId'] as String)
              .toList();
      final productQuery =
          await _db
              .collection('Products')
              .where(FieldPath.documentId, whereIn: productIds)
              .get();

      List<ProductModel> products =
          productQuery.docs
              .map((doc) => ProductModel.fromQuerySnapshot(doc))
              .toList();
      return products;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again. ${e.toString()}";
    }
  }
}
