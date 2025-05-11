import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/layouts/grid_layout.dart';
import 'package:new_flutter_app/common/widgets/loaders/animation_loader.dart';
import 'package:new_flutter_app/common/widgets/loaders/vertical_product_shimmer_effect.dart';
import 'package:new_flutter_app/common/widgets/products/products_card/custom_product_card_vertical.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/favourite_controller.dart';
import 'package:new_flutter_app/navigation_menu.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_flutter_app/utils/helpers/cloud_helper_function.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoriteController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Favourite',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const NavigationMenu()),
            icon: const Icon(Iconsax.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConstants.defaultSpace),
          child: Column(
            children: [
              Obx(
                () => FutureBuilder(
                  future: controller.favoriteProducts(),
                  builder: (context, snapshot) {
                    const loader = CustomVerticalProductShimmerEffect(
                      itemCount: 6,
                    );
                    final emptyWidget = Center(
                      child: CustomAnimationLoader(
                        text: "Hey! Wishlist is Empty...",
                        animation: ImageStringsConstants.favorite,
                        showAction: true,
                        actionText: 'Let\'s add some',
                        onActionPressed:
                            () => Get.offAll(() => const NavigationMenu()),
                      ),
                    );
                    final widget =
                        CustomCloudHelperFunction.checkMultiRecordState(
                          snapshot: snapshot,
                          loader: loader,
                          nothingFound: emptyWidget,
                        );
                    if (widget != null) return widget;

                    final products = snapshot.data!;
                    return CustomGridLayout(
                      itemCount: products.length,
                      itemBuilder:
                          (_, index) => CustomProductCardVertical(
                            product: products[index],
                          ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
