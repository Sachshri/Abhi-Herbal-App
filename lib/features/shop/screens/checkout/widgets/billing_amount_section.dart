import 'package:new_flutter_app/features/shop/controllers/cart_controller.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_app/utils/helpers/pricing_calculator.dart';

class CustomBillingAmountSection extends StatelessWidget {
  const CustomBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
        final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        // Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Subtotal',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text('\u20B9$subTotal', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: SizeConstants.spaceBtwItems / 2),
        // Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Shipping Fee',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text('\u20B9${PriceCalculator.calculateShippingCost(subTotal, 'IND',cartController.noOfCartItems.value)}', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: SizeConstants.spaceBtwItems / 2),
        // Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Tax Fee',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text('\u20B9${PriceCalculator.calculateTax(subTotal, 'IND')}', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: SizeConstants.spaceBtwItems / 2),
        // Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Order Total',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text('\u20B9${PriceCalculator.calculateTotalPrice(subTotal, 'IND',cartController.noOfCartItems.value)}', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: SizeConstants.spaceBtwItems / 2),
      ],
    );
  }
}
