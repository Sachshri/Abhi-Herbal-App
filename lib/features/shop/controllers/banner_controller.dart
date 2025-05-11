import 'package:get/get.dart';
import 'package:new_flutter_app/data/repositories/banners/banner_repository.dart';
import 'package:new_flutter_app/features/shop/models/banner_model.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  Rx<int> crouselCurrentIndex = 0.obs;
  RxList<BannerModel> allBanners = <BannerModel>[].obs;
  final bannerRepository = Get.put(BannerRepository());
  Rx<bool> isLoading = false.obs;
  //Change Crousel Index
  void changeCrouselIndex(index) {
    crouselCurrentIndex.value = index;
  }

  //Get all banners
  Future<void> fetchBanners() async {
    try {
      // Show Loader
      isLoading.value = true;
      //Fetch Banners
      final List<BannerModel> banners = await bannerRepository.fetchBanners();
      allBanners.assignAll(banners);
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: "Something Went Wrong.",
        message: "Banners Not Fetched! => ${e.toString()}",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
