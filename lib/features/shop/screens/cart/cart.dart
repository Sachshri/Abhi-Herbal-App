import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/loaders/animation_loader.dart';
import 'package:new_flutter_app/features/shop/controllers/cart_controller.dart';
import 'package:new_flutter_app/features/shop/screens/checkout/checkout.dart';
import 'package:new_flutter_app/features/shop/screens/cart/widgets/custom_list_cart_item.dart';
import 'package:new_flutter_app/navigation_menu.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      bottomNavigationBar:
          Obx(() {
            return controller.cartItems.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(SizeConstants.defaultSpace),
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const CheckoutScreen()),
                    child: Text(
                      'Checkout \u20B9${controller.totalCartPrice.value}',
                      style: Theme.of(context).textTheme.titleMedium
                    ),
                  ),
                );
          }),
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text("Cart", style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx(() {
        final emptyWidget = SingleChildScrollView(
          child: Center(
            child: CustomAnimationLoader(
              text: 'Hey! Cart is Empty..',
              animation: ImageStringsConstants.favorite,
              showAction: true,
              actionText: 'Let\'s fill it',
              onActionPressed: () => Get.offAll(() => const NavigationMenu()),
            ),
          ),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return SingleChildScrollView(
            child: const Padding(
              padding: EdgeInsets.all(SizeConstants.defaultSpace),
              // Items in cart
              child: CustomListCartItem(showAddRemove: true),
            ),
          );
        }
      }),
    );
  }
}
