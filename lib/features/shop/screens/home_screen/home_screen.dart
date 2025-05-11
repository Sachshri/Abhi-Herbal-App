import 'package:flutter/foundation.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/custom_search_bar.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/section_heading_with_button.dart';
import 'package:new_flutter_app/common/widgets/layouts/grid_layout.dart';
import 'package:new_flutter_app/common/widgets/loaders/shimmer_effect.dart';
import 'package:new_flutter_app/common/widgets/loaders/vertical_product_shimmer_effect.dart';
import 'package:new_flutter_app/common/widgets/products/products_card/custom_product_card_vertical.dart';
import 'package:new_flutter_app/features/personalization/controllers/user_controller.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/product_controller.dart';
import 'package:new_flutter_app/features/shop/screens/all_products/all_product.dart';
import 'package:new_flutter_app/features/shop/screens/home_screen/widgets/custom_category_list.dart';
import 'package:new_flutter_app/features/shop/screens/home_screen/widgets/custom_promo_slider.dart';
import 'package:new_flutter_app/features/shop/screens/home_screen/widgets/home_app_bar.dart';
import 'package:new_flutter_app/common/widgets/custom_shapes/curved_edges/primary_header.dart';
import 'package:new_flutter_app/features/shop/screens/home_screen/widgets/welcome_text.dart';
import 'package:new_flutter_app/features/shop/screens/search/search_screen.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final String downloadUrl = 'https://github.com/Sachshri/Abhi-Herbal-App/releases/download/v1.0.0/app-release.apk';
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final productController = Get.put(ProductController());

    return Scaffold(
      floatingActionButton:
          kIsWeb
              ? FloatingActionButton(
                onPressed: () => _launchURL(downloadUrl),
                child: const Column(children: [
                  Text("Apk"),
                  Icon(Icons.download_rounded)]),
              )
              : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderWidget(
              showImage: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //app bar
                  HomeAppBar(),
                  //welcome
                  Obx(() {
                    if (controller.profileLoading.value) {
                      return Padding(
                        padding: const EdgeInsets.all(
                          SizeConstants.defaultSpace,
                        ),
                        child: CustomShimmerEffect(height: 15, width: 80),
                      );
                    } else {
                      return WelcomeText(
                        welcomeText: TextStringsConstants.homePageWelcome,
                        welcomeTo: controller.user.value.firstName,
                      );
                    }
                  }),
                  //Search bar
                  const SizedBox(height: SizeConstants.spaceBtwItems),
                  CustomSearchBar(
                    icon: Icons.search,
                    hintText: TextStringsConstants.searchHint,
                    onTap: () => Get.to(() => SearchScreen()),
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConstants.defaultSpace,
                    ),
                  ),
                  const SizedBox(height: SizeConstants.spaceBtwItems),
                  //Categories
                  CustomCategoryList(),
                ],
              ),
            ),

            //Body Part
            Padding(
              padding: const EdgeInsets.all(SizeConstants.defaultSpace),
              child: Column(
                children: [
                  //promo slider
                  CustomPromoSlider(),
                  SizedBox(height: SizeConstants.spaceBtwSections),
                  //Popular Products
                  SectionHeadingWithButton(
                    sectionHeading: TextStringsConstants.popularProducts,
                    isButtonVisible: true,
                    onPressed:
                        () => Get.to(
                          () => AllProductScreen(
                            title: 'Popular Products',
                            futureMethod:
                                productController.fetchAllFeaturedProducts(),
                          ),
                        ),
                  ),
                  SizedBox(height: SizeConstants.spaceBtwItems),
                  Obx(() {
                    if (productController.isLoading.value) {
                      return CustomVerticalProductShimmerEffect();
                    }
                    if (productController.featuredProduct.isEmpty) {
                      return Center(
                        child: Text(
                          "No Data Found",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    return CustomGridLayout(
                      itemCount: productController.featuredProduct.length,
                      itemBuilder:
                          (_, index) => CustomProductCardVertical(
                            product: productController.featuredProduct[index],
                          ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
