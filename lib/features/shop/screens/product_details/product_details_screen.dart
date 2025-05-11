import 'package:new_flutter_app/common/widgets/custom_widgets/section_heading_with_button.dart';
import 'package:new_flutter_app/features/shop/controllers/cart_controller.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/features/shop/screens/checkout/checkout.dart';
import 'package:new_flutter_app/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:new_flutter_app/features/shop/screens/product_details/widgets/custom_rating_and_share.dart';
import 'package:new_flutter_app/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:new_flutter_app/features/shop/screens/product_details/widgets/product_details_image_slider.dart';
import 'package:new_flutter_app/features/shop/screens/product_details/widgets/product_metadata.dart';
import 'package:new_flutter_app/utils/constants/enums.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    // final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: BottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(   
          children: [
            // Product Image slider
            ProductImageSlider(product: product,),

            // Product Details
            Padding(
              padding: EdgeInsets.only(
                right: SizeConstants.defaultSpace,
                left: SizeConstants.defaultSpace,
                bottom: SizeConstants.defaultSpace,
              ),
              child: Column(
                children: [
                  // Rating & share
                  CustomRatingAndShare(),
                  // Price, Title ,Stock, Brand
                  ProductMetaData(product: product,),
                  // Attributes
                  if(product.productType!=ProductType.single.toString())
                  CustomProductAttributes(product: product,),
                  const SizedBox(height: SizeConstants.spaceBtwSections),
                  // Checkout button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => CartController.instance.noOfCartItems.value>0?Get.to(() => const CheckoutScreen()):CustomLoaders.warningSnackBar(
                        title: 'No Items in Cart',
                        message: 'Please add items to cart before checkout',
                      ),
                      child: Text('Checkout'),
                    ),
                  ),
                  // Description
                  const SizedBox(height: SizeConstants.spaceBtwSections),

                  const SectionHeadingWithButton(
                    sectionHeading: "Description",
                    isButtonVisible: false,
                  ),
                  const SizedBox(height: SizeConstants.spaceBtwItems / 2),
                  ReadMoreText(
                    '${product.description}',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Read More',
                    trimExpandedText: ' Less',
                    moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  //Reviews
                  // const Divider(),

                  const SizedBox(height: SizeConstants.spaceBtwItems),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const SectionHeadingWithButton(
                  //       sectionHeading: 'Reviews (199)',
                  //       isButtonVisible: false,
                  //     ),
                  //     IconButton(
                  //       onPressed:
                  //           () => Get.to(() => const ProductReviewScreen()),
                  //       icon: const Icon(Iconsax.arrow_right_3, size: 18),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: SizeConstants.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
