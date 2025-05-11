import 'package:flutter/material.dart';
import 'package:new_flutter_app/common/widgets/layouts/grid_layout.dart';
import 'package:new_flutter_app/common/widgets/loaders/shimmer_effect.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';

class CustomVerticalProductShimmerEffect extends StatelessWidget {
  const CustomVerticalProductShimmerEffect({super.key, this.itemCount = 4});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return  CustomGridLayout(itemCount: itemCount, itemBuilder: (_,__)=> 
    const SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomShimmerEffect(width: 180, height: 180),
          SizedBox(height: SizeConstants.spaceBtwItems,),

          CustomShimmerEffect(width: 160, height: 15),
          SizedBox(height: SizeConstants.spaceBtwItems/2,),
          CustomShimmerEffect(width: 110, height: 15),
        ],
      ) 
    ),
    );
  }
}
