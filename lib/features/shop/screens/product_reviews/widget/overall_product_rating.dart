import 'package:new_flutter_app/features/shop/screens/product_reviews/widget/rating_progress_indicator.dart';
import 'package:flutter/material.dart';

class OverallProductRating extends StatelessWidget {
  const OverallProductRating({super.key, required this.rating});
  final String rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(rating, style: Theme.of(context).textTheme.displayLarge),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              CustomRatingProgressIndicator(text: '5', value: 0.7),
              CustomRatingProgressIndicator(text: '4', value: 0.5),
              CustomRatingProgressIndicator(text: '3', value: 0.3),
              CustomRatingProgressIndicator(text: '2', value: 0.2),
              CustomRatingProgressIndicator(text: '1', value: 0.2),
            ],
          ),
        ),
      ],
    );
  }
}
