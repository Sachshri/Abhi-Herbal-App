import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/common/widgets/custom_text/custom_brand_title_verified_icon.dart';
import 'package:new_flutter_app/common/widgets/image_widgets/custom_circular_image.dart';
import 'package:new_flutter_app/features/shop/models/brand_model.dart';
import 'package:new_flutter_app/utils/constants/enums.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomBrandCard extends StatelessWidget {
  const CustomBrandCard({super.key, required this.showBorder, this.onTap, required this.brand});

  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: CustomRoundedContainer(
        padding: const EdgeInsets.all(SizeConstants.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            Flexible(
              child: CustomCircularImage(
                isNetworkImage: true,
                image: brand.image,
                backgroundColor: Colors.transparent,
                overlayColor: dark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(width: SizeConstants.spaceBtwItems / 2),
            // Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBrandTitleWithVerfiedIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '${brand.productsCount?? 0} items',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
