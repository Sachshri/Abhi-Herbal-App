import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/success_screen/success_screen.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/data/repositories/order/order_repository.dart';
import 'package:new_flutter_app/features/personalization/controllers/address_controller.dart';
import 'package:new_flutter_app/features/shop/controllers/cart_controller.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/checkout_controller.dart';
import 'package:new_flutter_app/features/shop/models/order_model.dart';
import 'package:new_flutter_app/navigation_menu.dart';
import 'package:new_flutter_app/utils/constants/enums.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';
import 'package:new_flutter_app/utils/popups/full_screen_loader.dart';
import 'package:uuid/uuid.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());
  final isLoading = false.obs;
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: 'Something Went Wrong!',
        message: e.toString(),
      );
      return [];
    }
  }

  // Process order
  void processOrder(double totalAmount) async {
    try {
      CustomFullScreenLoader.openLoadingDialog(
        'Processing your order',
        ImageStringsConstants.loading,
      );

      // Validate user authentication
      final user = AuthenticationRepository.instance.authUser;
      if (user == null || user.uid.isEmpty) {
        CustomLoaders.errorSnackBar(
          title: 'Error',
          message: 'User not authenticated',
        );
        return;
      }
      final userId = user.uid;

      // Validate payment method
      final paymentMethod = checkoutController.selectedPaymentMethod.value;

      // Validate address
      final address = addressController.selectedAddress.value;

      // Validate cart
      if (cartController.cartItems.isEmpty) {
        CustomLoaders.errorSnackBar(
          title: 'Error',
          message: 'Your cart is empty',
        );
        return;
      }

      final order = OrderModel(
        id: const Uuid().v4(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: paymentMethod.name,
        address: address,
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      // Save order to firestore
      await orderRepository.saveOrder(order, userId);

      // Clear cart and show success screen
      cartController.clearCart();
      // //'Navigating to success screen');
      CustomFullScreenLoader.closeLoadingDialog();
      Get.offAll(
        () => SuccessScreen(
          image: ImageStringsConstants.successImage,
          title: "Order Placed",
          subtitle: 'Your item will be shipped soon!',
          onPressed: () => Get.offAll(() => const NavigationMenu()),
          actionName: 'Get More',
        ),
      );
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: 'Order Processing Failed!',
        message: e.toString(),
      );
    }
  }
}
