import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/section_heading_with_button.dart';
import 'package:new_flutter_app/common/widgets/image_widgets/custom_circular_image.dart';
import 'package:new_flutter_app/features/personalization/controllers/user_controller.dart';
import 'package:new_flutter_app/features/personalization/screens/profile/change_name.dart';
import 'package:new_flutter_app/features/personalization/screens/profile/change_phone.dart';
import 'package:new_flutter_app/features/personalization/screens/profile/widgets/custom_profile_menu.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConstants.defaultSpace),
          child: Column(
            children: [
              //Profile Pictture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      return CustomCircularImage(
                        image: networkImage.isNotEmpty?networkImage: ImageStringsConstants.user ,
                        width: 80,
                        height: 80,
                        isNetworkImage: networkImage.isNotEmpty,
                      );
                    }),
                    TextButton(
                      onPressed: () => controller.updateUserProfilePicture(),
                      child: const Text("Change Profile Picture"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: SizeConstants.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: SizeConstants.spaceBtwItems),
              //Profile Info
              const SectionHeadingWithButton(
                sectionHeading: "Profile Information",
                isButtonVisible: false,
              ),
              const SizedBox(height: SizeConstants.spaceBtwItems),
              Obx(
                () => CustomProfileMenu(
                  title: "Name",
                  value: UserController.instance.user.value.fullName,
                  onPressed: () => Get.to(() => const ChangeName()),
                  showIcon: true,
                ),
              ),
              Obx(
                () => CustomProfileMenu(
                  title: "Username",
                  value: UserController.instance.user.value.username,
                  onPressed: () {},
                  showIcon: false,
                ),
              ),

              const SizedBox(height: SizeConstants.spaceBtwItems),
              const Divider(),
              const SizedBox(height: SizeConstants.spaceBtwItems),
              const SectionHeadingWithButton(
                sectionHeading: "Personal Information",
                isButtonVisible: false,
              ),
              const SizedBox(height: SizeConstants.spaceBtwItems),
              CustomProfileMenu(
                title: 'User ID',
                value: UserController.instance.user.value.id,
                icon: Iconsax.copy,
                showIcon: false,
              ),

              Obx(
                () => CustomProfileMenu(
                  onPressed: () => Get.to(() => const ChangePhone()),
                  title: 'Phone Number',
                  value: UserController.instance.user.value.phoneNumber,
                  showIcon: true,
                ),
              ),
              Obx(
                () => CustomProfileMenu(
                  onPressed: () {},
                  title: 'Email-ID',
                  value: UserController.instance.user.value.email,
                  showIcon: false,
                ),
              ),

              // CustomProfileMenu(
              //   onPressed: () {},
              //   title: 'Gender',
              //   value: 'Male',
              // ),

              // CustomProfileMenu(
              //   onPressed: () {},
              //   title: 'Date of Birth',
              //   value: '02 Nov 1934',
              // ),
              const Divider(),

              const SizedBox(height: SizeConstants.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ), // Center
            ],
          ),
        ),
      ),
    );
  }
}
