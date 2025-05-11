import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/section_heading_with_button.dart';
import 'package:new_flutter_app/common/widgets/image_widgets/custom_rounded_image.dart';
import 'package:new_flutter_app/common/widgets/loaders/horizontal_product_shimmer.dart';
import 'package:new_flutter_app/common/widgets/products/products_card/custom_product_card_horizontal.dart';
import 'package:new_flutter_app/features/shop/controllers/category_controller.dart';
import 'package:new_flutter_app/features/shop/models/category_model.dart';
import 'package:new_flutter_app/features/shop/screens/all_products/all_product.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_app/utils/helpers/cloud_helper_function.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: CustomAppBar(showBackArrow: true, title: Text(category.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConstants.defaultSpace),
          child: Column(
            // Banner
            children: [
              CustomRoundedImage(
                width: double.infinity,
                imageUrl: category.image,
                isApplyImageRadius: true,
                isNetworkImage: true,
                height: 200,
              ),
              const SizedBox(height: SizeConstants.spaceBtwSections),

              //SubCategories
              FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (context, snapshot) {
                  const loader = CustomHorizontalProductShimmerEffect();
                  final widget =
                      CustomCloudHelperFunction.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: loader,
                      );

                  if (widget != null) return widget;

                  final subCategories = snapshot.data!;
                  // //subCategories.length);
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final subCategory = subCategories[index];
                      // //'sub category${subCategory.id}');
                      return FutureBuilder(
                        future: controller.getCategoryProducts(
                          categoryId: subCategory.id,
                        ),
                        builder: (context, snapshot) {
                          final widget =
                              CustomCloudHelperFunction.checkMultiRecordState(
                                snapshot: snapshot,
                                loader: loader,
                              );

                          if (widget != null) return widget;
                          final products = snapshot.data!;
                          // //products.length);
                          return Column(
                            children: [
                              //Heading
                              SectionHeadingWithButton(
                                sectionHeading: subCategory.name,
                                isButtonVisible: true,
                                onPressed:
                                    () => Get.to(
                                      () => AllProductScreen(
                                        title: subCategory.name,
                                        futureMethod: controller
                                            .getCategoryProducts(
                                              categoryId: subCategory.id,
                                              limit: -1,
                                            ),
                                      ),
                                    ),
                              ),
                              const SizedBox(
                                height: SizeConstants.spaceBtwItems / 2,
                              ),

                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: products.length,
                                  separatorBuilder:
                                      (context, index) => const SizedBox(
                                        width: SizeConstants.spaceBtwItems,
                                      ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (context, index) =>
                                          CustomProductCardHorizontal(
                                            product: products[index],
                                          ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: SizeConstants.spaceBtwSections,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
