import 'package:flutter/material.dart';
import 'package:new_flutter_app/common/widgets/loaders/shimmer_effect.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';

class CustomHorizontalProductShimmerEffect extends StatelessWidget {
  const CustomHorizontalProductShimmerEffect({super.key, this.itemCount = 4});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: SizeConstants.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        
        itemBuilder:
            (_, __) => const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // image
                CustomShimmerEffect(width: 120, height: 120),
                SizedBox(width: SizeConstants.spaceBtwItems),

                // Text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: SizeConstants.spaceBtwItems/2),
                    CustomShimmerEffect(width: 130, height: 20),
                    SizedBox(height: SizeConstants.spaceBtwItems/2),
                    CustomShimmerEffect(width: 100, height: 20),
                    SizedBox(height: SizeConstants.spaceBtwItems/2),
                    SizedBox(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           CustomShimmerEffect(width: 30, height: 30),
                           CustomShimmerEffect(width: 40, height: 40),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
        separatorBuilder:
            (context, index) =>
                const SizedBox(width: SizeConstants.spaceBtwSections),
      ),
    );
  }
}
