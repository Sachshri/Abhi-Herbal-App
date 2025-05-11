import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_circular_container.dart';
import 'package:new_flutter_app/common/widgets/image_widgets/custom_rounded_image.dart';
import 'package:new_flutter_app/common/widgets/loaders/shimmer_effect.dart';
import 'package:new_flutter_app/features/shop/controllers/banner_controller.dart';
import 'package:new_flutter_app/features/shop/controllers/home_controller.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPromoSlider extends StatelessWidget {
  const CustomPromoSlider({super.key});
  @override
  Widget build(BuildContext context) {
    bool dark = HelperFunctions.isDarkMode(context);
    final bannerController = Get.put(BannerController());
    final controller = Get.put(HomeController());

    return Obx(() {
      if (bannerController.isLoading.value) {
        return const CustomShimmerEffect(width: double.infinity, height: 190);
      }
      if (bannerController.allBanners.isEmpty) {
        return const Center(child: Text("No Data Found"));
      }
      return Column(
        children: [
          CarouselSlider(
            items:
                bannerController.allBanners
                    .map(
                      (banner) => CustomRoundedImage(
                        imageUrl: banner.imageUrl,
                        isNetworkImage: true,
                        width: double.infinity,
                        backgroundColor:
                            dark ? Colors.black : ColorConstants.white,
                        borderRadius: SizeConstants.md,
                        isApplyImageRadius: true,
                        onPressed: () => Get.to(banner.targetScreen),
                      ),
                    )
                    .toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged:
                  (index, reason) => controller.changeCrouselIndex(index),
              // autoPlay: true,
            ),
          ),
          const SizedBox(height: SizeConstants.spaceBtwItems),
          Center(
            child: Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < bannerController.allBanners.length; i++)
                    CustomCircularContainer(
                      radius: 100,
                      width: 20,
                      height: 4,
                      margin: const EdgeInsets.only(right: 5),
                      color:
                          controller.crouselCurrentIndex.value == i
                              ? Colors.green
                              : Colors.grey,
                    ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
