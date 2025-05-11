import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/variation_controller.dart';
import 'package:new_flutter_app/features/shop/models/cart_item_model.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/utils/constants/enums.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';
import 'package:new_flutter_app/utils/local_storage/local_storage_utility.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = Get.put(VariationController());

  CartController() {
    initCartController();
  }

  Future<void> initCartController() async {
    final user = AuthenticationRepository.instance.authUser!.uid;
    await LocalStorageUtility.init(user);
    loadCartItems();
  }

  void saveCartItems() async {
    try {
      final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
      LocalStorageUtility.instance().saveData('cartItems', cartItemStrings);
    } catch (e) {
      //'error when saving cart items: $e');
    }
  }
  // void saveCartItems() async {
  //   final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
  //   final user = AuthenticationRepository.instance.authUser!.uid;
  //   await LocalStorageUtility.init(user);
  //   LocalStorageUtility.instance().saveData('cartItems', cartItemStrings);
  // }

  void loadCartItems() {
    try {
      final cartItemStrings = LocalStorageUtility.instance()
          .readData<List<dynamic>>('cartItems');

      if (cartItemStrings != null) {
        cartItems.assignAll(
          cartItemStrings.map(
            (item) => CartItemModel.fromJson(item as Map<String, dynamic>),
          ),
        );
        updateCartTotals();
      }
    } catch (e) {
      //'error when loading cart items: $e');
    }
  }
  //Add item in the cart

  void addToCart(ProductModel product) {
    if (productQuantityInCart.value < 1) {
      CustomLoaders.customToast(message: 'Select Quantity');
      return;
    }
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      CustomLoaders.customToast(message: 'Select Variation');
      return;
    }
    //Out of Stock Status
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        CustomLoaders.warningSnackBar(
          title: 'Out of Stock!',
          message: 'Selected Variation is out of Stock.',
        );
        return;
      }
    } else {
      if (product.stock < 1) {
        CustomLoaders.warningSnackBar(
          title: 'Out of Stock!',
          message: 'Selected Product is out of Stock.',
        );
        return;
      }
    }
    final selectedCartItem = convertToCartItem(
      product,
      productQuantityInCart.value,
    );
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == selectedCartItem.productId &&
          cartItem.variationId == selectedCartItem.variationId,
    );
    if (index >= 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    CustomLoaders.customToast(
      message: 'Your Product has been added to the Cart.',
    );
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
    }
    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Products',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        CustomLoaders.customToast(message: 'Product removed from the cart.');
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }
    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price =
        isVariation
            ? variation.salePrice > 0.0
                ? variation.salePrice
                : variation.price
            : product.salePrice! > 0.0
            ? product.salePrice
            : product.price;

    return CartItemModel(
      productId: product.id,
      quantity: quantity,
      price: price ?? 0.0,
      title: product.title,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : {},
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedNoOfItems += item.quantity;
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems.firstWhere(
      (item) => item.productId == productId,
      orElse: () => CartItemModel.empty(),
    );

    return foundItem.quantity;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems
        .where(
          (item) =>
              item.productId == productId && item.variationId == variationId,
        )
        .fold(0, (previousValue, element) => previousValue + element.quantity);

    return foundItem;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  // Initialize already added Items count in the cart

  void updateAlreadyAddedProductCount(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value = getVariationQuantityInCart(
          product.id,
          variationId,
        );
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }
}
