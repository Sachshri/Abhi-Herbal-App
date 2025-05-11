import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_flutter_app/common/widgets/loaders/shimmer_effect.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomCircularImage extends StatelessWidget {
  const CustomCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = SizeConstants.sm,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (HelperFunctions.isDarkMode(context) ? Colors.black : Colors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child:
              isNetworkImage
                  ? CachedNetworkImage(
                    imageUrl: image,
                    fit: fit,
                    progressIndicatorBuilder:
                        (context, url, progress) => const CustomShimmerEffect(
                          width: 55,
                          height: 55,
                          radius: 55,
                        ),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.image),
                  )
                  : Image(
                    fit: fit,
                    image: AssetImage(image),
                  ),
        ),
      ),
    );
  }
}
