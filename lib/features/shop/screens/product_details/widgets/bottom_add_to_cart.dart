import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:new_flutter_app/common/widgets/icons/custom_circular_icon.dart';
import 'package:new_flutter_app/features/shop/controllers/cart_controller.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    cartController.updateAlreadyAddedProductCount(product);
    final dark = HelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SizeConstants.defaultSpace,
        vertical: SizeConstants.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? ColorConstants.darkerGrey : ColorConstants.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(SizeConstants.cardRadiusLg),
          topRight: Radius.circular(SizeConstants.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: ColorConstants.darkGrey,
                  width: 40,
                  height: 40,
                  color: ColorConstants.white,
                  onPressed:
                      () =>
                          cartController.productQuantityInCart.value < 1
                              ? null
                              : cartController.productQuantityInCart.value -= 1,
                ),
                const SizedBox(width: SizeConstants.spaceBtwItems),
                Obx(
                  () => Text(
                    cartController.productQuantityInCart.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(width: SizeConstants.spaceBtwItems),
                CustomCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: ColorConstants.black,
                  width: 40,
                  height: 40,
                  color: ColorConstants.white,
                  onPressed:
                      () =>
                          cartController.productQuantityInCart.value < 0
                              ? null
                              : cartController.productQuantityInCart.value += 1,
                ),
              ],
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(SizeConstants.md),
                backgroundColor: ColorConstants.black,
                side: const BorderSide(color: ColorConstants.black),
              ),
              onPressed:
                  cartController.productQuantityInCart.value < 1
                      ? null
                      : () => cartController.addToCart(product),
              child: Text(
                'Add to Cart',
                style: TextStyle(
                  color:
                      cartController.productQuantityInCart.value < 1
                          ? const Color.fromARGB(143, 0, 0, 0)
                          : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
