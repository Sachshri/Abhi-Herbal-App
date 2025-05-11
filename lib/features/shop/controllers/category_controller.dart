import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/data/repositories/category/category_repository.dart';
import 'package:new_flutter_app/data/repositories/product/product_repository.dart';
import 'package:new_flutter_app/features/shop/controllers/cloudinary_storage_service.dart';
import 'package:new_flutter_app/features/shop/models/category_model.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/utils/exceptions/custom_exceptions.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> subCategories = <CategoryModel>[].obs;
  final RxBool isLoading = true.obs;
  final categoryRepository = Get.put(CategoryRepository());
  final _db = FirebaseFirestore.instance;
  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      // Show Loader
      isLoading.value = true;
      //Fetch Categories
      List<CategoryModel> categories =
          await categoryRepository.getAllCategories();

      //Filter Featured Categories

      // for (int i = 0; i < categories.length; i++) {
      //   if (categories[i].isFeatured == true) {
      //     featuredCategories.assign(categories[i]);
      //   }
      // }

    
      featuredCategories.assignAll(
        categories
            .where(
              (category) => category.isFeatured && category.parentId.isEmpty,
            )
            .take(4)
            .toList(),
      );
      allCategories.assignAll(
        categories.where((category) => category.parentId.isEmpty).toList(),
      );
      subCategories.assignAll(
        categories.where((category) => category.parentId.isNotEmpty).toList(),
      );
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: "Something Went Wrong.",
        message: "Categories Not Fetched! => ${e.toString()}",
      );
    } finally {
      isLoading.value = false;
    }
  }

  //Upload Data
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      final storage = Get.put(CustomCloudinaryStorageService());

      for (var category in categories) {
        // Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);
        //Upload Image and Get its URL
        final url = await storage.uploadImageData(file, category.name);
        // assing the Value
        category.image = url;

        // store category in firestore
        await _db
            .collection("Categories")
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again.";
    }
  }

  //Load Selected Category data
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategory = await categoryRepository.getSubCategories(categoryId);
      return subCategory;
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: "Something Went Wrong!",
        message: e.toString(),
      );
      return [];
    }
  }

  // Get Categoyr or sub Category products
  Future<List<ProductModel>> getCategoryProducts({
    required String categoryId,
    int limit = 4,
  }) async {
    final products = await ProductRepository.instance.getProductsForCategory(
      categoryId: categoryId,
      limit: limit,
    );
    return products;
  }
}
