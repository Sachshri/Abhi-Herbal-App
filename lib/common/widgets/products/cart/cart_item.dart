import 'package:new_flutter_app/common/widgets/custom_text/custom_brand_title_verified_icon.dart';
import 'package:new_flutter_app/common/widgets/image_widgets/custom_rounded_image.dart';
import 'package:new_flutter_app/features/shop/models/cart_item_model.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../custom_text/custom_product_title_text.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({super.key, this.onTap, required this.cartItem});
  final VoidCallback? onTap;
  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          CustomRoundedImage(
            imageUrl: cartItem.image ?? '',
            width: 60,
            height: 60,
            isNetworkImage: true,
            padding: const EdgeInsets.all(SizeConstants.sm),
            backgroundColor:
                HelperFunctions.isDarkMode(context)
                    ? ColorConstants.darkerGrey
                    : ColorConstants.light,
          ),
          const SizedBox(width: SizeConstants.spaceBtwItems),

          // Title Price & Size
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBrandTitleWithVerfiedIcon(title:cartItem.brandName??''),
                Flexible(
                  child: CustomProductTitleText(
                    title: cartItem.title,
                    maxLines: 1,
                  ),
                ),

                //Attributes
                Text.rich(
                  TextSpan(
                    children: 
                      (cartItem.selectedVariation ?? {})
                      .entries
                      .map(
                        (e) => 
                        TextSpan(
                          children: [
                            TextSpan(text: '${e.key}: ', style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(text: e.value, style: Theme.of(context).textTheme.bodyLarge),
                          ],
                          ),

                        ).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
