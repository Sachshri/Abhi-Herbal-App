import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  Rx<int> crouselCurrentIndex = 0.obs;

  void changeCrouselIndex(index) {
    crouselCurrentIndex.value = index;
  }
}