import 'package:new_flutter_app/common/widgets/icons/custom_circular_icon.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomProductQuantityAddRemove extends StatelessWidget {
  const CustomProductQuantityAddRemove({super.key, required this.quantity, this.add, this.remove});
  final int quantity;
  final VoidCallback? add, remove;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: SizeConstants.md,
          color:
              HelperFunctions.isDarkMode(context)
                  ? const Color.fromARGB(230, 35, 35, 35)
                  : const Color.fromARGB(230, 255, 255, 255),
          backgroundColor:
              HelperFunctions.isDarkMode(context)
                  ? const Color.fromARGB(255, 121, 115, 115)
                  : const Color.fromARGB(255, 72, 68, 68),
          onPressed: remove,
        ),

        const SizedBox(width: SizeConstants.spaceBtwItems),
        Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: SizeConstants.spaceBtwItems),
        CustomCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: SizeConstants.md,
          color: ColorConstants.white,
          backgroundColor: ColorConstants.primary,
          onPressed: add,
        ),
      ],
    );
  }
}
