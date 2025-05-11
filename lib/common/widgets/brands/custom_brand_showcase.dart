import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/common/widgets/loaders/shimmer_effect.dart';
import 'package:new_flutter_app/common/widgets/shop/custom_brand_card.dart';
import 'package:new_flutter_app/features/shop/models/brand_model.dart';
import 'package:new_flutter_app/features/shop/screens/all_products/all_product.dart';
import 'package:new_flutter_app/features/shop/screens/brand/brand_product.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBrandShowcase extends StatelessWidget {
  const CustomBrandShowcase({
    super.key,
    required this.images,
    required this.brand,
  });
  final BrandModel brand;
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: CustomRoundedContainer(
        showBorder: true,
        borderColor: ColorConstants.darkGrey,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: SizeConstants.spaceBtwItems),
        padding: const EdgeInsets.all(SizeConstants.md),
        child: Column(
          children: [
            // Product With Count
            CustomBrandCard(
              onTap: () => Get.to(() => const AllProductScreen(title: '')),
              showBorder: false,
              brand: brand,
            ),
            const SizedBox(height: SizeConstants.spaceBtwItems),
            Row(
              children:
                  images
                      .map<Widget>(
                        (image) => brandTopProductImageWidget(image, context),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: CustomRoundedContainer(
        height: 100,
        backgroundColor:
            HelperFunctions.isDarkMode(context)
                ? ColorConstants.darkGrey
                : ColorConstants.light,
        margin: const EdgeInsets.only(right: SizeConstants.sm),
        padding: const EdgeInsets.all(SizeConstants.md),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.contain,
          progressIndicatorBuilder:
              (context, url, downloadProgress) =>
                  const CustomShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => const Icon(Icons.image),
        ),
      ),
    );
  }
}
