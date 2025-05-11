import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomRatingAndShare extends StatelessWidget {
  const CustomRatingAndShare({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Rating
        Row(
          children: [
            Icon(Iconsax.star5, color: Colors.amber, size: 24),
            SizedBox(width: SizeConstants.spaceBtwItems / 2),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '4.7',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const TextSpan(text: "(199)"),
                ],
              ),
            ),
          ],
        ),
        //Share Button
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.share, size: SizeConstants.iconMd),
        ),
      ],
    );
  }
}
