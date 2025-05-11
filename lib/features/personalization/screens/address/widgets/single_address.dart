import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/features/personalization/controllers/address_controller.dart';
import 'package:new_flutter_app/features/personalization/models/address_model.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class CustomSingleAddress extends StatelessWidget {
  const CustomSingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = HelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.all(SizeConstants.md / 2),
      child: Obx(() {
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == address.id;
        return InkWell(
          onTap: onTap,
          child: CustomRoundedContainer(
            width: double.infinity,
            showBorder: true,
            backgroundColor:
                selectedAddress
                    ? ColorConstants.primary.withAlpha(127)
                    : Colors.transparent,
            borderColor:
                selectedAddress
                    ? Colors.transparent
                    : dark
                    ? ColorConstants.darkerGrey
                    : ColorConstants.grey,
            margin: const EdgeInsets.only(bottom: SizeConstants.spaceBtwItems),
            padding: const EdgeInsets.all(SizeConstants.md),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 5,
                  child: Icon(
                    selectedAddress ? Iconsax.tick_circle5 : null,
                    color:
                        selectedAddress
                            ? dark
                                ? ColorConstants.light
                                : ColorConstants.dark.withAlpha(156)
                            : null,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: SizeConstants.sm / 2),
                    Text(
                      '(+91) ${address.phoneNumber}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: SizeConstants.sm / 2),
                    Text(
                      // 'Huda sector 13-17, Panipat Near Police Station, Haryana',
                      address.toString(),
                      maxLines: 1,
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
