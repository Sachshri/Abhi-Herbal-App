import 'package:get/get.dart';
import 'package:new_flutter_app/data/repositories/product/upload_data_repository.dart';
import 'package:new_flutter_app/utils/data/dummy_data.dart';
import 'package:new_flutter_app/utils/helpers/network_manager.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';
import 'package:new_flutter_app/utils/popups/full_screen_loader.dart';

class UploadDataController extends GetxController {
  static UploadDataController get instance => Get.find<UploadDataController>();

  final uploadDataRepository = Get.put(UploadDataRepository());

  final isLoading = false.obs;

  Future<void> uploadProducts() async {
  try {
    // Show loading screen
    CustomFullScreenLoader.openLoadingDialog(
      'Adding Products to Database...',
      'assets/animations/loading.gif',
    );

    // Check internet connection
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      CustomFullScreenLoader.closeLoadingDialog();
      CustomLoaders.errorSnackBar(
        title: 'No Internet!',
        message: 'Please check your connection and try again.',
      );
      return;
    }

    await uploadDataRepository.uploadDummyProduct(CustomDummyData.products);

    // Close loading and show success
    CustomFullScreenLoader.closeLoadingDialog();
    CustomLoaders.successSnackBar(
      title: 'Success!',
      message: "Products have been uploaded successfully!",
    );

    // Optionally close the screen or navigate back
    // Navigator.of(Get.context!).pop();

  } catch (e) {
    CustomFullScreenLoader.closeLoadingDialog();
    CustomLoaders.errorSnackBar(
      title: 'Something Went Wrong!',
      message: e.toString(),
    );
  }
}
Future<void> uploadBanners() async {
  try {
    CustomFullScreenLoader.openLoadingDialog(
      'Uploading Banners to Database...',
      'assets/animations/loading.gif',
    );

    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      CustomFullScreenLoader.closeLoadingDialog();
      CustomLoaders.errorSnackBar(
        title: 'No Internet!',
        message: 'Please check your connection and try again.',
      );
      return;
    }

    await uploadDataRepository.uploadDummyBanners(CustomDummyData.banners); // <-- uses your static list

    CustomFullScreenLoader.closeLoadingDialog();
    CustomLoaders.successSnackBar(
      title: 'Success!',
      message: "Banners have been uploaded successfully!",
    );

  } catch (e) {
    CustomFullScreenLoader.closeLoadingDialog();
    CustomLoaders.errorSnackBar(
      title: 'Something Went Wrong!',
      message: e.toString(),
    );
  }
}
Future<void> uploadCategory() async {
  try {
    CustomFullScreenLoader.openLoadingDialog(
      'Uploading Categories to Database...',
      'assets/animations/loading.gif',
    );

    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      CustomFullScreenLoader.closeLoadingDialog();
      CustomLoaders.errorSnackBar(
        title: 'No Internet!',
        message: 'Please check your connection and try again.',
      );
      return;
    }

    await uploadDataRepository.uploadDummyCategories(CustomDummyData.categories); // <-- uses your static list

    CustomFullScreenLoader.closeLoadingDialog();
    CustomLoaders.successSnackBar(
      title: 'Success!',
      message: "Categories have been uploaded successfully!",
    );

  } catch (e) {
    CustomFullScreenLoader.closeLoadingDialog();
    CustomLoaders.errorSnackBar(
      title: 'Something Went Wrong!',
      message: e.toString(),
    );
  }
}


}