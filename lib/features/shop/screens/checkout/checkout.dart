import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/products/cart/custom_coupon_card.dart';
import 'package:new_flutter_app/features/shop/controllers/cart_controller.dart';
import 'package:new_flutter_app/features/shop/controllers/order_controller.dart';
import 'package:new_flutter_app/features/shop/screens/cart/widgets/custom_list_cart_item.dart';
import 'package:new_flutter_app/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:new_flutter_app/features/shop/screens/checkout/widgets/billing_payments_section.dart';
import 'package:new_flutter_app/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/utils/helpers/pricing_calculator.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController=OrderController.instance;
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final totalAmount=PriceCalculator.calculateTotalPrice(subTotal, 'IND',cartController.noOfCartItems.value);
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          "Order Review",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizeConstants.defaultSpace),
          child: Column(
            children: [
             Obx(() => cartController.noOfCartItems.value == 0 
                ? Text('Nothing in cart! Please add some', maxLines: 1, overflow: TextOverflow.fade)
                : CustomListCartItem(showAddRemove: false)),
              const SizedBox(height: SizeConstants.spaceBtwSections),

              /// Coupan TextField
              CustomCouponCode(),
              const SizedBox(height: SizeConstants.spaceBtwSections),
              // Billing Section
              CustomRoundedContainer(
                padding: const EdgeInsets.all(SizeConstants.md),
                showBorder: true,
                backgroundColor:
                    dark ? ColorConstants.black : ColorConstants.white,
                child: Column(
                  children: [
                    // Pricing
                    CustomBillingAmountSection(),
                    const SizedBox(height: SizeConstants.spaceBtwItems),
                    //Divider
                    const Divider(),
                    const SizedBox(height: SizeConstants.spaceBtwItems),
                    // Payment Methods
                    const CustomBillingPaymentSection(),
                    const SizedBox(height: SizeConstants.spaceBtwItems),

                    // Address
                    const CustomBillingAddressSection(),
                  ],
                ),
              ),
              const SizedBox(height: SizeConstants.spaceBtwSections),
            ],
          ),
        ),
      ),
      //Checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(SizeConstants.defaultSpace),
        child: ElevatedButton(
          onPressed:
              subTotal>0?()=>orderController.processOrder(totalAmount):()=> CustomLoaders.warningSnackBar(title: 'Empty Cart',message: 'Add items in the cart in order to proceed.',
              ),
          child: Text('Proceed \u20B9$totalAmount', style: Theme.of(context).textTheme.titleMedium),
        ),
      ),
    );
  }
}

