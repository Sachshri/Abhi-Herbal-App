import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/common/widgets/products/rating/custom_rating_bar_indicator.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(ImageStringsConstants.user),
                ),
                const SizedBox(width: SizeConstants.spaceBtwItems),
                Text(
                  'Jai Baba Ki',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: SizeConstants.spaceBtwItems),

        // Review
        Row(
          children: [
            CustomRatingBarIndicator(rating: 4.3),
            const SizedBox(width: SizeConstants.spaceBtwItems),
            Text('1 Nov, 2024', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: SizeConstants.spaceBtwItems),
        const ReadMoreText(
          'The use interface for app and review the product i was able to go any where very easily how are you borh',
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: 'show less',
          trimCollapsedText: 'show more',
          moreStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: ColorConstants.primary,
          ),
          lessStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: ColorConstants.primary,
          ),
        ),
        const SizedBox(height: SizeConstants.spaceBtwItems),

        CustomRoundedContainer(
          backgroundColor:
              dark ? ColorConstants.darkerGrey : ColorConstants.grey,
          child: Padding(
            padding: const EdgeInsets.all(SizeConstants.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Abhi Herbal',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '2 Nov, 2024',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: SizeConstants.spaceBtwItems),
                const ReadMoreText(
                  'The use interface for app and review the product i was able to go any where very easily how are you borh',
                  trimLines: 1,
                  trimMode: TrimMode.Line,
                  trimExpandedText: 'show less',
                  trimCollapsedText: 'show more',
                  moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primary,
                  ),
                  lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: SizeConstants.spaceBtwItems),
      ],
    );
  }
}
