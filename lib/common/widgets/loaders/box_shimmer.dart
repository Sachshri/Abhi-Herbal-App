import 'package:flutter/material.dart';
import 'package:new_flutter_app/common/widgets/loaders/shimmer_effect.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';

class CustomBoxShimmer extends StatelessWidget {
  const CustomBoxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: CustomShimmerEffect(width: 150, height: 110)),
            SizedBox(width: SizeConstants.spaceBtwItems,),
            Expanded(child: CustomShimmerEffect(width: 150, height: 110)),
            SizedBox(width: SizeConstants.spaceBtwItems,),
            Expanded(child: CustomShimmerEffect(width: 150, height: 110)),
          ],
        )
      ],
    );
  }
}