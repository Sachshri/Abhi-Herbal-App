import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/section_heading_with_button.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/checkout_controller.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomBillingPaymentSection extends StatelessWidget {
  const CustomBillingPaymentSection({super.key, this.isAvailable = false});
  final bool isAvailable;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final dark = HelperFunctions.isDarkMode(context);
    return Column(
      children: [
        SectionHeadingWithButton(
          sectionHeading: "Payment Method",
          isButtonVisible: true,
          buttonText: "Change",
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: SizeConstants.spaceBtwItems),
        Obx(
          () => Row(
            children: [
              CustomRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor:
                    dark ? ColorConstants.light : ColorConstants.white,
                padding: const EdgeInsets.all(SizeConstants.sm),
                child: Image(
                  image: AssetImage(
                    controller.selectedPaymentMethod.value.image,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: SizeConstants.spaceBtwItems / 2),
              Text(
                controller.selectedPaymentMethod.value.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
