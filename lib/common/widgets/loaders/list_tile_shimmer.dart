import 'package:flutter/material.dart';
import 'package:new_flutter_app/common/widgets/loaders/shimmer_effect.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';

class CustomListTileShimmer extends StatelessWidget {
  const CustomListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomShimmerEffect(width: 350, height: 150,radius: 50,),
        SizedBox(width: SizeConstants.spaceBtwItems,),
        Column(
          children: [
            CustomShimmerEffect(width: 10, height: 15),
            SizedBox(height: SizeConstants.spaceBtwItems/2,),
            CustomShimmerEffect(width: 80, height: 12),
          ],
        )
      ],
    );
  }
}