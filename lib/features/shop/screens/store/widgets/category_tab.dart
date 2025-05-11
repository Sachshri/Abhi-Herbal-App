import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/section_heading_with_button.dart';
import 'package:new_flutter_app/common/widgets/layouts/grid_layout.dart';
import 'package:new_flutter_app/common/widgets/loaders/vertical_product_shimmer_effect.dart';
import 'package:new_flutter_app/common/widgets/products/products_card/custom_product_card_vertical.dart';
import 'package:new_flutter_app/features/shop/controllers/category_controller.dart';
import 'package:new_flutter_app/features/shop/models/category_model.dart';
import 'package:new_flutter_app/features/shop/screens/all_products/all_product.dart';
import 'package:new_flutter_app/features/shop/screens/store/widgets/category_brands.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_app/utils/helpers/cloud_helper_function.dart';

class CustomCategoryTab extends StatelessWidget {
  const CustomCategoryTab({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    // //category.id);
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(SizeConstants.defaultSpace),
          child: Column(
            children: [
              // brands
              CategoryBrands(category: category),

              const SizedBox(height: SizeConstants.spaceBtwItems),
              // Products
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {
                  final response =
                      CustomCloudHelperFunction.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: const CustomVerticalProductShimmerEffect(),
                      );
                  if (response != null) return response;
                  final products = snapshot.data!;

                  return Column(
                    children: [
                      SectionHeadingWithButton(
                        sectionHeading: "You Might Like",
                        onPressed:
                            () => Get.to(
                              AllProductScreen(
                                title: category.name,
                                futureMethod: controller.getCategoryProducts(
                                  categoryId: category.id,
                                  limit: -1,
                                ),
                              ),
                            ),
                      ),
                      const SizedBox(height: SizeConstants.spaceBtwItems),

                      CustomGridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) {
                          return CustomProductCardVertical(
                            product: products[index],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: SizeConstants.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
