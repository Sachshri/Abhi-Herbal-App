import 'package:new_flutter_app/common/widgets/image_widgets/custom_circular_image.dart';
import 'package:new_flutter_app/features/personalization/controllers/user_controller.dart';
import 'package:new_flutter_app/features/personalization/screens/profile/profile_screen.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomUserProfileTile extends StatelessWidget {
  const CustomUserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ListTile(
      
      leading: Obx(() {
                      final networkImage = UserController.instance.user.value.profilePicture;
                      return CustomCircularImage(
                        image: networkImage.isNotEmpty?networkImage: ImageStringsConstants.user ,
                        width: 50,
                        height: 50,
                        isNetworkImage: networkImage.isNotEmpty,
                      );
                    }),
      title: Obx(
        () => Text(
          UserController.instance.user.value.fullName,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.apply(color: ColorConstants.white),
        ),
      ),
      subtitle: Obx(
        () => Text(
          UserController.instance.user.value.email,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.apply(color: ColorConstants.white),
        ),
      ),
      trailing: IconButton(
        onPressed: () => Get.to(const ProfileScreen()),
        icon: const Icon(Iconsax.edit, color: ColorConstants.white),
      ),
    );
  }
}
