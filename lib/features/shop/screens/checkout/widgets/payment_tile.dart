import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/checkout_controller.dart';
import 'package:new_flutter_app/features/shop/models/payment_method_model.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';

class CustomPaymentTile extends StatelessWidget {
  const CustomPaymentTile({super.key, required this.paymentMethod});
  final PaymentMethodModel paymentMethod;
  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: CustomRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor:
            HelperFunctions.isDarkMode(context)
                ? ColorConstants.light
                : ColorConstants.white,
        padding: EdgeInsets.all(SizeConstants.sm),
        child: Image(
          image: AssetImage(paymentMethod.image),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
