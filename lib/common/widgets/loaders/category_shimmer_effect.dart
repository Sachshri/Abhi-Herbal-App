import 'package:flutter/material.dart';
import 'package:new_flutter_app/common/widgets/loaders/shimmer_effect.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';

class CustomCategoryShimmerEffect extends StatelessWidget {
  const CustomCategoryShimmerEffect({super.key,this.itemCount=4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder:
            (_, __) => const SizedBox(width: SizeConstants.spaceBtwItems),
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              CustomShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: SizeConstants.spaceBtwItems / 2),

              /// Text
              CustomShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}
