import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/products/rating/custom_rating_bar_indicator.dart';
import 'package:new_flutter_app/features/shop/screens/product_reviews/widget/overall_product_rating.dart';
import 'package:new_flutter_app/features/shop/screens/product_reviews/widget/user_review_card.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(("Reviews & Ratings")),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(SizeConstants.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Rating and Reviews are verified and are from people who use ethe same type of device that yhou use.",
            ),
            const SizedBox(height: SizeConstants.spaceBtwItems),

            // Overall Product Rating
            const OverallProductRating(rating: '4.6'),
            const CustomRatingBarIndicator(rating: 4.6),
            Text('12,622', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: SizeConstants.spaceBtwSections),

            //User Review
            const UserReviewCard(),
            const UserReviewCard(),
            const UserReviewCard(),
          ],
        ),
      ),
    );
  }
}
