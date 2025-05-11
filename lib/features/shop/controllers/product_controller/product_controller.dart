import 'package:get/get.dart';
import 'package:new_flutter_app/data/repositories/product/product_repository.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/utils/constants/enums.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  RxList<ProductModel> featuredProduct = <ProductModel>[].obs;
  final productRepository = Get.put(ProductRepository());
  final isLoading = false.obs;
  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }


  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      //Fetch Product
      final products = await productRepository.getFeaturedProducts();
      //Assign Product
      featuredProduct.assignAll(products);
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: "Something Went Wrong",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final products = await productRepository.getAllFeaturedProducts();
      return products;
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: "Something Went Wrong",
        message: e.toString(),
      );
      return [];
    }
  }

  //Get the product price and price range for variation
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice! > 0
              ? '\u{20B9}${product.salePrice}'
              : '\u{20B9}${product.price}')
          .toString();
    } else {
      for (var variation in product.productVariations!) {
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }
    }

    if (smallestPrice != largestPrice) {
      return '\u{20B9}$smallestPrice - \u{20B9}$largestPrice';
    }
    return '\u{20B9}${smallestPrice.toString()}';
  }

  String? calculateSalePricePercentage(
    double originalPrice,
    double? salePrice,
  ) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;
    double percentage = (((originalPrice - salePrice) / originalPrice)) * 100;
    return percentage.toStringAsFixed(0);
  }

  String getProductStockStatus(int stock) {
    return stock > 0 ? 'Available: $stock' : 'Out of Stock';
  }

  // Future<void> uploadProducts() async{
  //   try {
  //     isLoading.value = true;
  //     //'Uploading Dummy Data...');
  //     await productRepository.uploadDummyData(CustomDummyData.products);
  //     //'Dummy Data Uploaded Successfully!');
  //   } catch (e) {
  //     CustomLoaders.errorSnackBar(
  //       title: "Something Went Wrong",
  //       message: e.toString(),
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
