import 'package:new_flutter_app/common/widgets/custom_widgets/section_heading_with_button.dart';
import 'package:new_flutter_app/common/widgets/image_widgets/custom_vertical_image_text.dart';
import 'package:new_flutter_app/common/widgets/loaders/category_shimmer_effect.dart';
import 'package:new_flutter_app/features/shop/controllers/category_controller.dart';
import 'package:new_flutter_app/features/shop/screens/sub_category/sub_category.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCategoryList extends StatelessWidget {
  const CustomCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(SizeConstants.md),
          child: const SectionHeadingWithButton(
            sectionHeading: TextStringsConstants.categories,
            textColor: Colors.black,
          ),
        ),
        // Categories List
        Obx(() {
          if (controller.isLoading.value) {
            return CustomCategoryShimmerEffect(itemCount: 4);
          }
          if (controller.featuredCategories.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: SizeConstants.defaultSpace,
              ),
              child: Text(
                "No Data Found",
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.apply(color: Colors.white),
              ),
            );
          } else {
            return Container(
              height: 150,
              padding: const EdgeInsets.only(
                left: SizeConstants.md,
                top: SizeConstants.sm,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.featuredCategories.length,
                itemBuilder: (context, index) {
                  final category = controller.featuredCategories[index];
                  return CustomVerticalImageText(
                    imageUrl: category.image,
                    title: category.name,
                    onTap:
                        () => Get.to(
                          () => SubCategoryScreen(
                            category: category,
                          ),
                        ),
                  );
                },
              ),
            );
          }
        }),
      ],
    );
  }
}
