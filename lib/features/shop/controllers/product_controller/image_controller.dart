import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  //Variables
  RxString selectedProductImage = ''.obs;

  // --Get all Image From product and variations
  List<String> getAllProductImages(ProductModel product) {
    Set<String> images = {};
    //thumbnail image
    images.add(product.thumbnail);

    //asssing thumbnail image
    selectedProductImage.value = product.thumbnail;
    //Get all images from product model if not null
    if (product.images != null) {
      images.addAll(product.images!);
    }

    //Get all images from the product variation if not null
    if (product.productVariations != null ||
        product.productVariations!.isNotEmpty) {
      images.addAll(
        product.productVariations!.map((variation) => variation.image),
      );
    }
    return images.toList();
  }

/// -- Show Image Popup
void showEnlargedImage(String image) {
  Get.to(
    () => Dialog.fullscreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: SizeConstants.defaultSpace * 2, 
                horizontal: SizeConstants.defaultSpace),
            child: CachedNetworkImage(imageUrl: image),
          ),
          SizedBox(height: SizeConstants.spaceBtwSections),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: () => Get.back(), 
                child: const Text("Close"),
              ),
            ), 
          ), 
        ],
      ), 
    ), 
  );
}

}
