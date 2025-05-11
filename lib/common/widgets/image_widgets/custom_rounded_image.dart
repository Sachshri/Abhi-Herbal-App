import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_flutter_app/common/widgets/loaders/shimmer_effect.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';

class CustomRoundedImage extends StatelessWidget {
  const CustomRoundedImage({
    super.key,
    this.onPressed,
    this.width,
    this.height,
    this.border,
    this.fit = BoxFit.contain,
    this.backgroundColor,
    required this.imageUrl,
    this.isNetworkImage = false,
    this.isApplyImageRadius = false,
    this.padding,
    this.borderRadius = SizeConstants.md,
  });
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final BoxBorder? border;
  final double borderRadius;
  final Color? backgroundColor;
  final BoxFit? fit;
  final String imageUrl;
  final bool isNetworkImage;
  final bool isApplyImageRadius;
  final EdgeInsetsGeometry? padding;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius:
              isApplyImageRadius
                  ? BorderRadius.circular(SizeConstants.md)
                  : BorderRadius.zero,
          child:   isNetworkImage
                  ? CachedNetworkImage(
                    imageUrl: imageUrl,
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
                    image: AssetImage(imageUrl),
                    // color:
                    //     overlayColor ??
                    //     (HelperFunctions.isDarkMode(context)
                    //         ? Colors.white
                    //         : Colors.black),
                  ),
        ),
      ),
    );
  }
}
