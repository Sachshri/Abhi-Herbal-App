import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_flutter_app/features/shop/controllers/cart_controller.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/features/shop/screens/product_details/product_details_screen.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/enums.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';

class ProudctCardAddToCartButton extends StatelessWidget {
  const ProudctCardAddToCartButton({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailsScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart = cartController.getProductQuantityInCart(
          product.id,
        );

        return Container(
          decoration: BoxDecoration(
            color:
                productQuantityInCart > 0
                    ? ColorConstants.primary
                    : ColorConstants.dark,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(SizeConstants.cardRadiusMd),
              bottomRight: Radius.circular(SizeConstants.productImageRadius),
            ),
          ),
          child: SizedBox(
            width: SizeConstants.iconLg * 1.2,
            height: SizeConstants.iconLg * 1.2,
            child: Center(
              child:
                  productQuantityInCart <= 0
                      ? Icon(Iconsax.add, color: ColorConstants.white)
                      : Text(
                        productQuantityInCart.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: ColorConstants.white,
                        ),
                      ),
            ),
          ),
        );
      }),
    );
  }
}