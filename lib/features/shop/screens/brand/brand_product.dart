import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/loaders/vertical_product_shimmer_effect.dart';
import 'package:new_flutter_app/common/widgets/products/sortable/custom_sortable_product.dart';
import 'package:new_flutter_app/common/widgets/shop/custom_brand_card.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/brand_controller.dart';
import 'package:new_flutter_app/features/shop/models/brand_model.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_app/utils/helpers/cloud_helper_function.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: CustomAppBar(showBackArrow: true, title: Text(brand.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConstants.defaultSpace),
          child: Column(
            children: [
              // Brand Detail
              CustomBrandCard(showBorder: true, brand: brand),
              SizedBox(height: SizeConstants.spaceBtwSections),

              FutureBuilder(
                future: controller.getBrandProducts(brandId:brand.id),
                builder: (context, snapshot) {
                  const loader = CustomVerticalProductShimmerEffect();
                  final widget =
                      CustomCloudHelperFunction.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: loader,
                      );
                  if (widget != null) return widget;

                  final products=snapshot.data!;
                  return CustomSortableProduct(products: products);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
