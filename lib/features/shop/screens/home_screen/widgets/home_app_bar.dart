import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/loaders/shimmer_effect.dart';
import 'package:new_flutter_app/common/widgets/products/cart/counter_icon.dart';
import 'package:new_flutter_app/features/personalization/controllers/user_controller.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return CustomAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextStringsConstants.appBarTitle,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.apply(color: ColorConstants.black),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              return CustomShimmerEffect(height:15,width: 80, );
            } else {
              return Text(
                controller.user.value.fullName,
                style: Theme.of(context).textTheme.labelMedium!.apply(
                  color: const Color.fromARGB(200, 35, 35, 35),
                ),
              );
            }
          }),
        ],
      ),
      actions: [
        CounterIcon(icon: Icon(Iconsax.shopping_bag)),
      ],
    );
  }
}
