import 'package:new_flutter_app/common/styles/custom_shadow_style.dart';
import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/common/widgets/custom_text/custom_brand_title_verified_icon.dart';
import 'package:new_flutter_app/common/widgets/custom_text/custom_product_title_text.dart';
import 'package:new_flutter_app/common/widgets/custom_text/product_price_text.dart';
import 'package:new_flutter_app/common/widgets/image_widgets/custom_rounded_image.dart';
import 'package:new_flutter_app/common/widgets/products/products_card/faviourite/faviourite_icon.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/product_controller.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/common/widgets/products/cart/product_card_add_to_cart_button.dart';
import 'package:new_flutter_app/features/shop/screens/product_details/product_details_screen.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomProductCardVertical extends StatelessWidget {
  const CustomProductCardVertical({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePrice = product.salePrice;
    final originalPrice = product.price;
    final String? salePercentage = controller.calculateSalePricePercentage(
      originalPrice,
      salePrice,
    );
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [CustomShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(SizeConstants.productImageRadius),
          color:
              dark
                  ? const Color.fromARGB(41, 147, 147, 147)
                  : const Color.fromARGB(41, 157, 155, 155),
        ),
        child: Column(
          children: [
            /// Thumbnail, WishList Button, Discount Tag
            CustomRoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(SizeConstants.sm),
              backgroundColor:
                  dark
                      ? ColorConstants.dark
                      : const Color.fromARGB(144, 188, 186, 186),
              child: Stack(
                children: [
                  /// -- Thumbnail Image
                  Center(
                    child: CustomRoundedImage(
                      imageUrl: product.thumbnail,
                      isApplyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  /// sales tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: CustomRoundedContainer(
                        radius: SizeConstants.sm,
                        backgroundColor: ColorConstants.secondary.withAlpha(
                          200,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: SizeConstants.sm,
                          vertical: SizeConstants.xs,
                        ),
                        child: Text(
                          '-$salePercentage%',
                          style: Theme.of(context).textTheme.labelLarge!.apply(
                            color: ColorConstants.black,
                          ),
                        ),
                      ),
                    ),

                  /// -- Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CustomFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),

            /// -- Details
            Padding(
              padding: const EdgeInsets.only(left: SizeConstants.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomProductTitleText(
                    title: product.title,
                    smallSize: false,
                  ),
                  const SizedBox(height: SizeConstants.spaceBtwItems / 2),
                  CustomBrandTitleWithVerfiedIcon(title: product.brand!.name),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price
                Flexible(
                  child: Column(
                    children: [
                      // if(product.productType==ProductType.single.toString() && product.salePrice!>0)
                      Padding(
                        padding: const EdgeInsets.only(left: SizeConstants.sm),
                        child: CustomProductPriceText(
                          currencySign: '',
                          price: controller.getProductPrice(product),
                        ),
                      ),
                    ],
                  ),
                ),
                //Add to cart button
                ProudctCardAddToCartButton(product: product),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


