import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/section_heading_with_button.dart';
import 'package:new_flutter_app/features/shop/models/payment_method_model.dart';
import 'package:new_flutter_app/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();
  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(
      image: ImageStringsConstants.cashOnDelivery,
      name: 'Cash On Delivery',
    );
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder:
          (_) => SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(SizeConstants.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeadingWithButton(
                    sectionHeading: 'Select Payment Method',
                    isButtonVisible: false,
                  ),
                  SizedBox(height: SizeConstants.spaceBtwSections),
                  CustomPaymentTile(
                    paymentMethod: PaymentMethodModel(
                      name: 'Cash On Delivery',
                      image: ImageStringsConstants.cashOnDelivery,
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
    );
  }
}

