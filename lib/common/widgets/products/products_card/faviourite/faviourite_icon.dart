import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_flutter_app/common/widgets/icons/custom_circular_icon.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/favourite_controller.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';

class CustomFavouriteIcon extends StatelessWidget {
  const CustomFavouriteIcon({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    final controller = FavoriteController.instance;
    return Obx(
      () => CustomCircularIcon(
        icon: controller.isFavorite(productId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavorite(productId) ? ColorConstants.error : null,
        onPressed: ()=> controller.toggleFavoriteProduct(productId),
      ),
    );
  }
}
