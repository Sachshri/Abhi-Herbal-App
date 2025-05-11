import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/common/widgets/custom_text/custom_brand_title_verified_icon.dart';
import 'package:new_flutter_app/common/widgets/custom_text/custom_product_title_text.dart';
import 'package:new_flutter_app/common/widgets/custom_text/product_price_text.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/product_controller.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/enums.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePrice = product.salePrice;
    final originalPrice = product.price;
    final String? salePercentage = controller.calculateSalePricePercentage(
      originalPrice,
      salePrice,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Price and Sales Price
        Row(
          children: [
            // Sale Tag
            if (product.productType == ProductType.single.toString() && product.salePrice! > 0)
            CustomRoundedContainer(
              radius: SizeConstants.sm,
              backgroundColor: ColorConstants.secondary.withAlpha(200),
              padding: const EdgeInsets.symmetric(
                horizontal: SizeConstants.sm,
                vertical: SizeConstants.xs,
              ),
              child: Text(
                '-$salePercentage%',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.apply(color: ColorConstants.black),
              ),
            ),

            //Price
            if(product.productType==ProductType.single.toString() && product.salePrice!>0)
            Text(
              '\u20B9${product.price}',
              style: Theme.of(context).textTheme.titleSmall!.apply(
                decoration: TextDecoration.lineThrough,
              ),
            ),
            if(product.productType!=ProductType.single.toString() && product.salePrice!>0)
            const SizedBox(width: SizeConstants.spaceBtwItems),

            CustomProductPriceText(price: controller.getProductPrice(product), isLarge: true,currencySign: '',),
          ],
        ),
        const SizedBox(height: SizeConstants.spaceBtwItems / 1.5),
        //Title
        CustomProductTitleText(title: product.title),
        const SizedBox(height: SizeConstants.spaceBtwItems / 1.5),

        //Stock Status
        Row(
          children: [
            const CustomProductTitleText(title: 'Availability'),
            const SizedBox(width: SizeConstants.spaceBtwItems),
            Text(controller.getProductStockStatus(product.stock), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: SizeConstants.spaceBtwItems / 1.5),
        // Brand
        
        Row(
          children: [
            // CustomCircularImage(image: product.brand!=null? product.brand!.image:'',width: 32,height: 32,overlayColor: darkMode? ColorConstants.white: ColorConstants.black,),
            CustomBrandTitleWithVerfiedIcon(
              title: product.brand!=null?product.brand!.name:'',
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
