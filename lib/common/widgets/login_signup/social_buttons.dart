import 'package:get/get.dart';
import 'package:new_flutter_app/features/authentication/controllers/login/login_controller.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: controller.googleSignIn,
            icon: const Image(
              height: SizeConstants.iconMd,
              width: SizeConstants.iconMd,
              image: AssetImage(ImageStringsConstants.google),
            ),
          ),
        ),
        // const SizedBox(
        //   height: SizeConstants.spaceBtwItems,
        // ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              height: SizeConstants.iconMd,
              width: SizeConstants.iconMd,
              image: AssetImage(ImageStringsConstants.facebook),
            ),
          ),
        ),
      ],
    );
  }
}
