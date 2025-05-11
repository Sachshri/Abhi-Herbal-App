import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/features/shop/controllers/cloudinary_storage_service.dart';
import 'package:new_flutter_app/features/shop/models/banner_model.dart';
import 'package:new_flutter_app/features/shop/models/category_model.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';

class UploadDataRepository extends GetxController {
  static UploadDataRepository get instance => Get.find();

  // Add your repository methods and properties here
  // For example, you can define a method to upload products
  Future<void> uploadDummyProduct(List<ProductModel> products) async {
    try {
      final storage = Get.put(CustomCloudinaryStorageService());
      final firestore = FirebaseFirestore.instance;

      for (var product in products) {
        // Upload thumbnail
        final thumbnailData = await storage.getImageDataFromAssets(
          product.thumbnail,
        );
        final thumbnailUrl = await storage.uploadImageData(
          thumbnailData,
          product.thumbnail.toString(),
          folderName: 'Products/Images',
        );
        product.thumbnail = thumbnailUrl;

        // Upload product images
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

        // // Upload brand image
        // if (product.brand!.image.isNotEmpty) {
        //   final brandImageData = await storage.getImageDataFromAssets(product.brand!.image);
        //   final brandImageUrl = await storage.uploadImageData(
        //     brandImageData,
        //     product.brand!.image,
        //     folderName: 'Brands/Images',
        //   );
        //   product.brand!.image = brandImageUrl;
        // }

        // Convert product to a Map (make sure your ProductModel has a toJson method)
        final productMap = product.toJson();

        // Save to Firestore (collection: 'products')
        await firestore.collection('Products').doc(product.id).set(productMap);

        //"✅ Product '${product.title}' uploaded successfully!");
      }
    } catch (e) {
      //"❌ Error uploading data: $e");
      throw e.toString();
    }
  }

  Future<void> uploadDummyBanners(List<BannerModel> banners) async {
    try {
      final storage = Get.put(CustomCloudinaryStorageService());
      final firestore = FirebaseFirestore.instance;

      for (var banner in banners) {
        // Upload banner image from asset
        final imageData = await storage.getImageDataFromAssets(banner.imageUrl);
        final imageUrl = await storage.uploadImageData(
          imageData,
          banner.imageUrl,
          folderName: 'Banners/Images',
        );

        // Update imageUrl with Cloudinary URL
        banner.imageUrl = imageUrl;

        // Save to Firestore
        await firestore.collection('Banners').add(banner.toJson());

        //"✅ Uploaded banner: ${banner.targetScreen}");
      }
    } catch (e) {
      //"❌ Error uploading banners: $e");
      throw e.toString();
    }
  }

  Future<void> uploadDummyCategories(List<CategoryModel> categories) async {
    try {
      final storage = Get.put(CustomCloudinaryStorageService());
      final firestore = FirebaseFirestore.instance;

      for (var category in categories) {
        // Upload banner image from asset
        final imageData = await storage.getImageDataFromAssets(category.image);
        final imageUrl = await storage.uploadImageData(
          imageData,
          category.image,
          folderName: 'Categories/Images',
        );

        // Update imageUrl with Cloudinary URL
        category.image = imageUrl;

        // Save to Firestore
        await firestore
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());

        //"✅ Uploaded Categories: ${category.name}");
      }
    } catch (e) {
      //"❌ Error uploading banners: $e");
      throw e.toString();
    }
  }
}
