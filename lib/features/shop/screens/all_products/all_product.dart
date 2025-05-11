import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/loaders/vertical_product_shimmer_effect.dart';
import 'package:new_flutter_app/common/widgets/products/sortable/custom_sortable_product.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/all_product_controller.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_app/utils/helpers/cloud_helper_function.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({
    super.key,
    required this.title,
    this.query,
    this.futureMethod,
  });
  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: CustomAppBar(showBackArrow: true, title: Text(title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConstants.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {
              const loader = CustomVerticalProductShimmerEffect();
              final widget = CustomCloudHelperFunction.checkSingleRecordState(
                snapshot,
                loader
              );
              if (widget != null) return widget;

              final products = snapshot.data!;

              return CustomSortableProduct(products: products);
            },
          ),
        ),
      ),
    );
  }
}
