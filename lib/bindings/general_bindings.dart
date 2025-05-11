import 'package:get/get.dart';
import 'package:new_flutter_app/features/personalization/controllers/address_controller.dart';
import 'package:new_flutter_app/features/shop/controllers/cart_controller.dart';
import 'package:new_flutter_app/features/shop/controllers/category_controller.dart';
import 'package:new_flutter_app/features/shop/controllers/cloudinary_storage_service.dart';
import 'package:new_flutter_app/features/shop/controllers/order_controller.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/checkout_controller.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/favourite_controller.dart';
import 'package:new_flutter_app/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(CartController());
    Get.put(FavoriteController());
    Get.put(AddressController());
    Get.put(CheckoutController());
    Get.put(OrderController());
    Get.put(CustomCloudinaryStorageService());
    Get.put(CategoryController());
  }
}
