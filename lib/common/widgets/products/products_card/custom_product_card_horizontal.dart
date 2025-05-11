import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/common/widgets/custom_text/custom_brand_title_verified_icon.dart';
import 'package:new_flutter_app/common/widgets/custom_text/custom_product_title_text.dart';
import 'package:new_flutter_app/common/widgets/custom_text/product_price_text.dart';
import 'package:new_flutter_app/common/widgets/image_widgets/custom_rounded_image.dart';
import 'package:new_flutter_app/common/widgets/products/cart/product_card_add_to_cart_button.dart';
import 'package:new_flutter_app/common/widgets/products/products_card/faviourite/faviourite_icon.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/product_controller.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/features/shop/screens/product_details/product_details_screen.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/enums.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomProductCardHorizontal extends StatelessWidget {
  const CustomProductCardHorizontal({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePrice = product.salePrice;
    final originalPrice = product.price;
    final String? salePercentage =
        controller.calculateSalePricePercentage(originalPrice, salePrice);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
      child: Container(
        width: 330,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConstants.productImageRadius),
          color: dark ? ColorConstants.darkerGrey : ColorConstants.softGrey,
        ),
        child: Row(
          children: [
            // Thumbnail
            CustomRoundedContainer(
              showBorder: true,
              height: 120,
              padding: const EdgeInsets.all(SizeConstants.sm),
              backgroundColor: dark ? ColorConstants.dark : ColorConstants.light,
              child: Stack(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: CustomRoundedImage(
                      imageUrl: product.thumbnail,
                      isApplyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  // Sale Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: CustomRoundedContainer(
                        radius: SizeConstants.sm,
                        backgroundColor:
                            ColorConstants.secondary.withAlpha(200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: SizeConstants.sm,
                          vertical: SizeConstants.xs,
                        ),
                        child: Text(
                          '-$salePercentage%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: ColorConstants.black),
                        ),
                      ),
                    ),

                  // Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CustomFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),

            // Detail
            SizedBox(
              width: 190,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: SizeConstants.sm,
                  left: SizeConstants.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomProductTitleText(
                      title: product.title,
                      smallSize: true,
                    ),
                    const SizedBox(height: SizeConstants.spaceBtwItems / 2),
                    CustomBrandTitleWithVerfiedIcon(title: product.brand!.name),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Pricing
                        Flexible(
                          child: Column(
                            children: [
                              if(product.productType==ProductType.single.toString() && product.salePrice!>0)
                              Padding(
                                padding: const EdgeInsets.only(left: SizeConstants.sm),
                                child: Text(
                                  product.price.toString(),
                                  style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: SizeConstants.sm),
                                child: CustomProductPriceText(
                                  price: controller.getProductPrice(product),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Add To Cart
                        ProudctCardAddToCartButton(product: product),
                        
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}