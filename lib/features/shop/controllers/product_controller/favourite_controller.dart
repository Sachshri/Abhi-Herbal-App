import 'dart:convert';

import 'package:get/get.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/data/repositories/product/product_repository.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';
import 'package:new_flutter_app/utils/local_storage/local_storage_utility.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initController();
  }

  get storeFavorites => null;

  Future<void> initController() async {
    final user = AuthenticationRepository.instance.authUser!.uid;
    await LocalStorageUtility.init(user);
    initfavorites();
  }

  Future<void> initfavorites() async {
    try {
      final json = LocalStorageUtility.instance().readData('favorites');
      if (json != null) {
        final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
        favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)),
        );
      }
    } catch (e) {
      //'error when initializing favorites: $e');
    }
  }

  void saveFavoritesToStorage() {
    try {
      final encodedFavorites = json.encode(favorites);
      LocalStorageUtility.instance().saveData('favorites', encodedFavorites);
    } catch (e) {
      //'error when saving favorites: $e');
    }
  }
  // @override
  // void onInit() {
  //   super.onInit();
  //   initfavorites();
  // }

  // Future<void> initfavorites() async {
  //   final user = AuthenticationRepository.instance.authUser!.uid;
  //   await LocalStorageUtility.init(user);
  //   final json = LocalStorageUtility.instance().readData('favorites');
  //   if (json != null) {
  //     final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
  //     favorites.assignAll(
  //       storedFavorites.map((key, value) => MapEntry(key, value as bool)),
  //     );
  //   }
  // }

  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      CustomLoaders.customToast(message: "Product has been added to WishList.");
    } else {
      LocalStorageUtility.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
    }
  }

  // void saveFavoritesToStorage(){
  //   final encodedFavorites = json.encode(favorites);
  //   LocalStorageUtility.instance().saveData('favorites', encodedFavorites);
  // }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance.getFavouriteProduct(
      favorites.keys.toList(),
    );
  }
}
