import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/section_heading_with_button.dart';
import 'package:new_flutter_app/common/widgets/layouts/grid_layout.dart';
import 'package:new_flutter_app/common/widgets/loaders/brand_shimmer.dart';
import 'package:new_flutter_app/common/widgets/shop/custom_brand_card.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/brand_controller.dart';
import 'package:new_flutter_app/features/shop/screens/brand/brand_product.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: CustomAppBar(showBackArrow: true, title: Text('Category')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConstants.defaultSpace),
          child: Column(
            children: [
              //Heading
              SectionHeadingWithButton(sectionHeading: "Categories"),
              SizedBox(height: SizeConstants.spaceBtwItems),
              Obx(() {
                        if (controller.isLoading.value) {
                          return const CustomBrandShimmer();
                        }

                        if (controller.allBrands.isEmpty) {
                          return Center(
                            child: Text(
                              "No Data Found",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .apply(color: Colors.white),
                            ),
                          );
                        }
                        return CustomGridLayout(
                          itemCount: controller.allBrands.length,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            final brand = controller.allBrands[index];
                            return CustomBrandCard(
                              showBorder: true,
                              brand: controller.allBrands[index],
                              onTap: () => Get.to(() => BrandProducts(brand:brand,)),
                            );
                          },
                        );
                      }),
              SizedBox(height: SizeConstants.spaceBtwItems),

              //Brands
            ],
          ),
        ),
      ),
    );
  }
}
