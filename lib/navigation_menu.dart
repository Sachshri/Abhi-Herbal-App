import 'package:new_flutter_app/features/personalization/screens/settings/setting_screen.dart';
import 'package:new_flutter_app/features/shop/screens/home_screen/home_screen.dart';
import 'package:new_flutter_app/features/shop/screens/wishlist/favourite_screen.dart';
import 'package:new_flutter_app/features/shop/screens/article/article_screen.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationBarController());
    bool dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected:
              (index) => {controller.selectedIndex.value = index},
          indicatorColor:
              dark
                  ? const Color.fromARGB(30, 255, 255, 255)
                  : const Color.fromARGB(30, 0, 0, 0),
          backgroundColor: dark ? Colors.black : Colors.white,
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
            NavigationDestination(icon: Icon(Iconsax.receipt_add), label: "Artices"),
            NavigationDestination(
              icon: Icon(Iconsax.heart),
              label: "Favourite",
            ),
            NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationBarController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomeScreen(),
    // StoreScreen(),
    ArticleScreen(),
    FavouriteScreen(),
    SettingScreen(),
  ];
}
