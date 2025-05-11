import 'package:get/get.dart';
import 'package:new_flutter_app/data/repositories/brand/brand_repository.dart';
import 'package:new_flutter_app/data/repositories/product/product_repository.dart';
import 'package:new_flutter_app/features/shop/models/brand_model.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();
  final brandRepository = Get.put(BrandRepository());
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxBool isLoading = true.obs;
  @override
  void onInit() {
    fetchFeaturedBrands();
    super.onInit();
  }

  //Load Brands
  Future<void> fetchFeaturedBrands() async {
    try {
      isLoading.value = true;
      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);
      featuredBrands.assignAll(
        allBrands.where((brand) => brand.isFeatured ?? false).take(4).toList(),
      );
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: "Something Went Wrong",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Get Brands For Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: "Something Went Wrong!",
        message: e.toString(),
      );
      return [];
    }
  }

  // Get Brand Specific Products from your data source
  Future<List<ProductModel>> getBrandProducts({required String brandId,int limit=-1}) async {
    try {
      final products = await ProductRepository.instance.getProductsForBrand(
        brandId: brandId,
        limit: limit
      );
      return products;
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: 'Something Went Wrong!',
        message: e.toString(),
      );
      return [];
    }
  }
}
