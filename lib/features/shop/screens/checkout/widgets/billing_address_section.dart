import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/section_heading_with_button.dart';
import 'package:new_flutter_app/features/personalization/controllers/address_controller.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';

class CustomBillingAddressSection extends StatelessWidget {
  const CustomBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeadingWithButton(
          sectionHeading: "Shipping Address",
          isButtonVisible: true,
          buttonText: "Change",
          onPressed: () => addressController.selectNewAddressPopup(context),
        ),
      Obx(() => addressController.selectedAddress.value.id.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(addressController.selectedAddress.value.name,
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: SizeConstants.spaceBtwItems / 2),
                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.grey, size: 16),
                    const SizedBox(width: SizeConstants.spaceBtwItems),
                    Expanded(
                      child: Text(
                        '(+91) ${addressController.selectedAddress.value.phoneNumber}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SizeConstants.spaceBtwItems / 2),
                Row(
                  children: [
                    const Icon(Icons.location_history, color: Colors.grey, size: 16),
                    const SizedBox(width: SizeConstants.spaceBtwItems),
                    Expanded(
                      child: Text(
                        addressController.selectedAddress.value.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Text(
              'Select Address',
              style: Theme.of(context).textTheme.bodyMedium,
            ))
      ],
    );
  }
}
