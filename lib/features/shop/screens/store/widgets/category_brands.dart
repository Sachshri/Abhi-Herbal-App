import 'package:flutter/material.dart';
import 'package:new_flutter_app/common/widgets/brands/custom_brand_showcase.dart';
import 'package:new_flutter_app/common/widgets/loaders/box_shimmer.dart';
import 'package:new_flutter_app/common/widgets/loaders/list_tile_shimmer.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/brand_controller.dart';
import 'package:new_flutter_app/features/shop/models/category_model.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/cloud_helper_function.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {
        // Handling Error and Loaders
        const loader = Column(
          children: [
            CustomListTileShimmer(),
            SizedBox(height: SizeConstants.spaceBtwItems),
            CustomBoxShimmer(),
            SizedBox(height: SizeConstants.spaceBtwItems),
          ],
        );
        final widget = CustomCloudHelperFunction.checkMultiRecordState(
          snapshot: snapshot,
          loader: loader,
        );
        if (widget != null) return widget;

        final brands = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (_, index) {
            final brand = brands[index];
            return FutureBuilder(
              future: controller.getBrandProducts(brandId: brand.id, limit: 3),
              builder: (context, snapshot) {
                final widget = CustomCloudHelperFunction.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                );
                if (widget != null) return widget;

                final products = snapshot.data!;
                return CustomBrandShowcase(brand: brand, images: products.map((e)=> e.thumbnail).toList());
              },
            );
          },
        );
      },
    );
  }
}
