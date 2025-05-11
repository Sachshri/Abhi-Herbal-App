import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/layouts/grid_layout.dart';
import 'package:new_flutter_app/common/widgets/products/products_card/custom_product_card_vertical.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/all_product_controller.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomSortableProduct extends StatelessWidget {
  const CustomSortableProduct({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        //Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            controller.sortProducts(value!);
          },
          items:
              ["Name", "Higher Price", "Sale", "Newest", "Popularity"]
                  .map(
                    (option) =>
                        DropdownMenuItem(value: option, child: Text(option)),
                  )
                  .toList(),
        ),
        const SizedBox(height: SizeConstants.spaceBtwItems),
        Obx(
          () => CustomGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              return CustomProductCardVertical(
                product: controller.products[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
