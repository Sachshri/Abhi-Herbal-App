import 'package:new_flutter_app/features/shop/controllers/cart_controller.dart';
import 'package:new_flutter_app/features/shop/screens/cart/cart.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterIcon extends StatelessWidget {
  const CounterIcon({
    super.key,
    required this.icon,
    this.color = const Color.fromARGB(255, 247, 18, 18),
    this.iconColor = Colors.black,
  });
  final Icon? icon;
  final Color? iconColor;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final dark = HelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: icon!,
          color: !dark ? iconColor : Colors.white,
        ),
        Positioned(
          top: 5,
          right: 10,
          child: Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              color:
                  !dark
                      ? const Color.fromARGB(64, 0, 0, 0)
                      : const Color.fromARGB(64, 255, 255, 255),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.noOfCartItems.value.toString(),
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                    color:
                        color ?? (dark ? ColorConstants.black : Colors.white),
                    fontSizeFactor: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
