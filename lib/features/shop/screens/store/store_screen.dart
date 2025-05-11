import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_tab_bar.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/custom_search_bar.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/section_heading_with_button.dart';
import 'package:new_flutter_app/common/widgets/layouts/grid_layout.dart';
import 'package:new_flutter_app/common/widgets/loaders/brand_shimmer.dart';
import 'package:new_flutter_app/common/widgets/shop/custom_brand_card.dart';
import 'package:new_flutter_app/common/widgets/products/cart/counter_icon.dart';
import 'package:new_flutter_app/features/shop/controllers/category_controller.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/brand_controller.dart';
import 'package:new_flutter_app/features/shop/screens/brand/all_brand.dart';
import 'package:new_flutter_app/features/shop/screens/brand/brand_product.dart';
import 'package:new_flutter_app/features/shop/screens/search/search_screen.dart';
import 'package:new_flutter_app/features/shop/screens/store/widgets/category_tab.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            CounterIcon(
              icon: Icon(Iconsax.shopping_bag),
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor:
                    HelperFunctions.isDarkMode(context)
                        ? Colors.black
                        : Colors.white,
                automaticallyImplyLeading: false,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(SizeConstants.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      //Search Bar
                      const SizedBox(height: SizeConstants.spaceBtwItems),
                      CustomSearchBar(
                        hintText: 'Search in Store',
                        showBackground: false,
                        padding: EdgeInsets.zero,
                        icon: Icons.search,
                        onTap: () => Get.to(() => const SearchScreen()),
                      ),
                      const SizedBox(height: SizeConstants.spaceBtwSections),

                      //Featured Products
                      SectionHeadingWithButton(
                        sectionHeading: 'Featured Categories',
                        isButtonVisible: true,
                        onPressed: () => Get.to(() => const AllBrandScreen()),
                      ),
                      const SizedBox(height: SizeConstants.spaceBtwItems / 1.5),

                      Obx(() {
                        if (brandController.isLoading.value) {
                          return const CustomBrandShimmer();
                        }

                        if (brandController.featuredBrands.isEmpty) {
                          return Center(
                            child: Text(
                              "No Data Found",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .apply(color: Colors.white),
                            ),
                          );
                        }
                        return CustomGridLayout(
                          itemCount: brandController.featuredBrands.length,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            final brand = brandController.featuredBrands[index];
                            return CustomBrandCard(
                              showBorder: true,
                              brand: brandController.featuredBrands[index],
                              onTap: () => Get.to(() => BrandProducts(brand:brand,)),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
                bottom: CustomTabBar(
                  tabs:
                      categories
                          .map((category) => Tab(child: Text(category.name)))
                          .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children:
                categories
                    .map((category) => CustomCategoryTab(category: category))
                    .toList(),
          ),
        ),
      ),
    );
  }
}
