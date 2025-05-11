import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/custom_shapes/containers/curved_edge_container.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/image_widgets/custom_rounded_image.dart';
import 'package:new_flutter_app/common/widgets/loaders/shimmer_effect.dart';
import 'package:new_flutter_app/common/widgets/products/products_card/faviourite/faviourite_icon.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/image_controller.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/color_constants.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageController());
    final images = controller.getAllProductImages(product);
    return ClipPathContainer(
      child: Container(
        color: dark ? ColorConstants.darkerGrey : ColorConstants.light,
        child: Stack(
          children: [
            // Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(
                  SizeConstants.productImageRadius * 2,
                ),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    if(image.isEmpty){
                      
                    }
                    return GestureDetector(
                      onTap: ()=> controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        // progressIndicatorBuilder:
                        //     (_, __, downloadProgress) =>
                        //         CircularProgressIndicator(
                        //           value: downloadProgress.progress,
                        //           color: ColorConstants.primary,
                        //         ),
                        progressIndicatorBuilder:
                          (context, url, progress) => const CustomShimmerEffect(
                            width: 55,
                            height: 55,
                            radius: 55,
                          ),
                        errorWidget:
                          (context, url, error) => const Icon(Icons.image),
                          ),
                    );
                  }),
                ),
              ),
            ),

            // Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: SizeConstants.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder:
                      (_, __) =>
                          const SizedBox(width: SizeConstants.spaceBtwItems),
                  itemCount: images.length,
                  itemBuilder:
                      (_, index) => Obx(() {
                        final imageSelected =
                            controller.selectedProductImage.value ==
                            images[index];
                        return CustomRoundedImage(
                          width: 80,
                          isNetworkImage: true,
                          onPressed: () {
                            controller.selectedProductImage.value =
                                images[index];
                          },
                          backgroundColor:
                              dark ? ColorConstants.dark : ColorConstants.white,
                          border: Border.all(color:imageSelected? ColorConstants.primary:Colors.transparent),
                          padding: const EdgeInsets.all(SizeConstants.sm),
                          imageUrl: images[index],
                        );
                      }),
                ),
              ),
            ),
            //Appbar Icon
            CustomAppBar(
              showBackArrow: true,
              actions: [
                CustomFavouriteIcon(productId: product.id,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


