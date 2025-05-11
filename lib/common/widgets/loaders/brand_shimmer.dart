import 'package:flutter/material.dart';
import 'package:new_flutter_app/common/widgets/layouts/grid_layout.dart';
import 'package:new_flutter_app/common/widgets/loaders/shimmer_effect.dart';

class CustomBrandShimmer extends StatelessWidget {
  const CustomBrandShimmer({super.key, this.itemCount=4});
  
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return CustomGridLayout (
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_,__)=> const CustomShimmerEffect(width: 300, height: 80),
    );
  }
}