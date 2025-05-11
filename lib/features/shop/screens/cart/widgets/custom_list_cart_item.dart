import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/common/widgets/custom_text/product_price_text.dart';
import 'package:new_flutter_app/common/widgets/products/cart/add_remove_button.dart';
import 'package:new_flutter_app/common/widgets/products/cart/cart_item.dart';
import 'package:new_flutter_app/features/shop/controllers/cart_controller.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/features/shop/screens/product_details/product_details_screen.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomListCartItem extends StatelessWidget {
  const CustomListCartItem({super.key, required this.showAddRemove});
  final bool showAddRemove;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: controller.cartItems.length,
        separatorBuilder:
            (_, __) => const SizedBox(height: SizeConstants.spaceBtwSections),
        itemBuilder: (_, index) {
          return CustomRoundedContainer(
            padding: const EdgeInsets.all(SizeConstants.defaultSpace),
            showBorder: true,
            backgroundColor: dark ? ColorConstants.dark : ColorConstants.light,
            child: Obx(() {
              final item = controller.cartItems[index];
              return Column(
                children: [
                  // Cart Items
                  CustomCartItem(
                    cartItem: item,
                    onTap:
                        () => Get.to(
                          () => ProductDetailsScreen(
                            product: ProductModel.empty(),
                          ),
                        ),
                  ),
                  if (showAddRemove)
                    const SizedBox(height: SizeConstants.spaceBtwItems),

                  ///Add Remove BUttno  with total Price
                  if (showAddRemove)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Add Remove Button
                        Row(
                          children: [
                            const SizedBox(width: 70),
                            CustomProductQuantityAddRemove(
                              quantity: item.quantity,
                              add: () => controller.addOneToCart(item),
                              remove: () => controller.removeOneFromCart(item),
                            ),
                          ],
                        ),
                        CustomProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1)),
                      ],
                    ),
                ],
              );
            }),
          );
        },
      ),
    );
  }
}
