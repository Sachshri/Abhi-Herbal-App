import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/common/widgets/loaders/animation_loader.dart';
import 'package:new_flutter_app/features/shop/controllers/order_controller.dart';
import 'package:new_flutter_app/navigation_menu.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/enums.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/cloud_helper_function.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';

class CustomOrderListItems extends StatelessWidget {
  const CustomOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    final dark = HelperFunctions.isDarkMode(context);

    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (context, snapshot) {
        final emptyWidget = Center(
          child: CustomAnimationLoader(
            text: 'Hey! No Orders Yet...',
            animation: ImageStringsConstants.favorite,
            actionText: 'Order Now',
            showAction: true,
            onActionPressed: () => Get.offAll(() => const NavigationMenu()),
          ),
        );

        final response = CustomCloudHelperFunction.checkMultiRecordState(
          snapshot: snapshot,
          nothingFound: emptyWidget,
        );

        if (response != null) return response;

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return emptyWidget;
        }

        final orders = snapshot.data!;

        // Splitting Orders into 'Delivered' & 'On the Way'
        final deliveredOrders = orders.where((order) => order.status == OrderStatus.delivered).toList();
        final onTheWayOrders = orders.where((order) => order.status != OrderStatus.delivered).toList();

        return SingleChildScrollView(
          child: Column(
            children: [
              // On the Way Section
              _buildSectionHeader(context, "On the Way"),
              if (onTheWayOrders.isNotEmpty)
                _buildOrderList(onTheWayOrders, context, dark)
              else
                CustomAnimationLoader(
          text: 'Hey! No Orders Yet...',
          animation: ImageStringsConstants.favorite,
          actionText: 'Order Now',
          showAction: true,
          onActionPressed: () => Get.offAll(() => const NavigationMenu()),
                ),
          
              const SizedBox(height: SizeConstants.spaceBtwSections),
          
              // Delivered Section
              if (deliveredOrders.isNotEmpty) ...[
                _buildSectionHeader(context, "Completed"),
                _buildOrderList(deliveredOrders, context, dark),
              ],
                ],
          ),
        );
      },
    );
  }

  // Helper method to build section header
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SizeConstants.md),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall!.apply(
              color: ColorConstants.primary,
              fontWeightDelta: 2,
            ),
      ),
    );
  }

  // Helper method to build order list
  Widget _buildOrderList(List orders, BuildContext context, bool dark) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: SizeConstants.spaceBtwItems),
      itemBuilder: (context, index) {
        final order = orders[index];

        return CustomRoundedContainer(
          padding: const EdgeInsets.all(SizeConstants.md),
          showBorder: true,
          backgroundColor: dark ? ColorConstants.dark : ColorConstants.light,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Order Status and Date Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Iconsax.ship),
                      SizedBox(width: SizeConstants.spaceBtwItems / 2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.orderStatusText,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: ColorConstants.primary, fontWeightDelta: 1),
                          ),
                          Text(
                            order.formattedOrderDate,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Iconsax.arrow_right_34, size: SizeConstants.iconSm),
                  ),
                ],
              ),

              const SizedBox(height: SizeConstants.spaceBtwItems),

              // Order ID & Shipping Date Row
              Row(
                children: [
                  // Order ID Section
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Iconsax.tag),
                        SizedBox(width: SizeConstants.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(color: ColorConstants.primary, fontWeightDelta: 1),
                              ),
                              Text(
                                order.id,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: SizeConstants.spaceBtwItems),

                  // Shipping Date Section
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Iconsax.calendar),
                        SizedBox(width: SizeConstants.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Shipping Date",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(color: ColorConstants.primary, fontWeightDelta: 1),
                              ),
                              Text(
                                order.formattedDeliveryDate,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

