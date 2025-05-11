import 'package:new_flutter_app/common/widgets/custom_shapes/curved_edges/primary_header.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/section_heading_with_button.dart';
import 'package:new_flutter_app/common/widgets/list_tile/custom_user_profile_tile.dart';
import 'package:new_flutter_app/common/widgets/list_tile/settings_menu_tile.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/features/personalization/controllers/user_controller.dart';
import 'package:new_flutter_app/features/personalization/screens/address/address.dart';
import 'package:new_flutter_app/features/personalization/screens/upload_data/upload_data.dart';
import 'package:new_flutter_app/features/personalization/screens/privacy_policy/privacy_terms.dart';
import 'package:new_flutter_app/features/shop/screens/order/order.dart';
import 'package:new_flutter_app/features/shop/screens/cart/cart.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderWidget(
              showImage: false,
              child: Column(
                children: [
                  CustomAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: SizeConstants.spaceBtwSections),

                  //User Profile Card
                  CustomUserProfileTile(),
                  const SizedBox(height: SizeConstants.spaceBtwSections),
                ],
              ),
            ),
            // Body
            Padding(
              padding: EdgeInsets.all(SizeConstants.defaultSpace),
              child: Column(
                children: [
                  // Account Settings
                  SectionHeadingWithButton(
                    sectionHeading: 'Account Settings',
                    isButtonVisible: false,
                  ),
                  SizedBox(height: SizeConstants.spaceBtwItems),
                  CustomSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: "My Addrsses",
                    subTitle: "Set Shopping Delivery address",
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  CustomSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: "My Cart",
                    subTitle: "Add, remove products and move to checkout",
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
                  CustomSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: "My Order",
                    subTitle: "In-progress and Completed Orders",
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  // CustomSettingsMenuTile(
                  //   icon: Iconsax.bank,
                  //   title: "Bank Account",
                  //   subTitle: "Withdraw balance to registered bank account",
                  //   onTap: () {},
                  // ),
                  // CustomSettingsMenuTile(
                  //   icon: Iconsax.discount_shape,
                  //   title: "My Coupons",
                  //   subTitle: "List of all the discounted Coupons",
                  //   onTap: () {},
                  // ),
                  // CustomSettingsMenuTile(
                  //   icon: Iconsax.notification,
                  //   title: "Notifications",
                  //   subTitle: "Set any kind of notification messages",
                  //   onTap: () {},
                  // ),
                  // CustomSettingsMenuTile(
                  //   icon: Iconsax.security_card,
                  //   title: "Account Privacy",
                  //   subTitle: "Manage data usage and connections",
                  //   onTap: () {},
                  // ),

                  // App Setting
                  SizedBox(height: SizeConstants.spaceBtwSections),

                  SectionHeadingWithButton(
                    sectionHeading: 'App Settings',
                    isButtonVisible: false,
                  ),
                  SizedBox(height: SizeConstants.spaceBtwItems),
                  Center(child: Text('New Settings are coming soon!')),

                  if(userController.user.value.role=='admin')
                  CustomSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: "Load Data",
                    subTitle: "Upload Data to your Cloud Firebase",
                    onTap: () => Get.to(() => const UploadDataScreen()),
                  ),

                  // CustomSettingsMenuTile(
                  //   icon: Iconsax.location,
                  //   title: "Geolocation",
                  //   subTitle: "Set recommendation based on location",
                  //   trailing: Switch(value: true, onChanged: (value) {}),
                  // ),
                  // CustomSettingsMenuTile(
                  //   icon: Iconsax.security_user,
                  //   title: "Safe Mode",
                  //   subTitle: "Serach result is safe for all ages",
                  //   trailing: Switch(value: true, onChanged: (value) {}),
                  // ),
                  // CustomSettingsMenuTile(
                  //   icon: Iconsax.image,
                  //   title: "Hd Image Quality",
                  //   subTitle: "Set image Quality to be seen",
                  //   trailing: Switch(value: false, onChanged: (value) {}),
                  // ),
                  //Logout button
                  const SizedBox(height: SizeConstants.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed:
                          () => AuthenticationRepository.instance.logout(),
                      child: const Text("Logout"),
                    ),
                  ),
                  const SizedBox(height: SizeConstants.spaceBtwSections),
                  SectionHeadingWithButton(
                    sectionHeading: 'Privacy Policy',
                    isButtonVisible: true,
                    buttonText: "View",
                    onPressed: () => Get.to(() => PolicyTermsScreen()),
                  ),
                  const SizedBox(height: SizeConstants.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
