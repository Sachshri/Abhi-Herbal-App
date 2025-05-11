import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomCouponCode extends StatelessWidget {
  const CustomCouponCode({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return CustomRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? ColorConstants.dark : ColorConstants.white,
      padding: const EdgeInsets.only(
        top: SizeConstants.sm,
        bottom: SizeConstants.sm,
        right: SizeConstants.sm,
        left: SizeConstants.md,
      ),
      child: Row(
        children: [
          Flexible(
            // TextField
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here',
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
          ),
          // Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor:
                    dark
                        ? const Color.fromARGB(127, 255, 255, 255)
                        : const Color.fromARGB(127, 39, 39, 39),
                backgroundColor: const Color.fromRGBO(158, 158, 158, 0.2),
                side: BorderSide(
                  color: const Color.fromARGB(
                    127,
                    158,
                    158,
                    158,
                  ).withAlpha(127),
                ),
              ),
              onPressed: () {},
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}
