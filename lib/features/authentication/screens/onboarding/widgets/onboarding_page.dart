import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? image;
  const OnBoardingPage({super.key, this.image, this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SizeConstants.defaultSpace,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            height: 0.6 * HelperFunctions.screenHeight(),
            width: 0.6 * HelperFunctions.screenWidth(),
            image: AssetImage(image!),
          ),
          Text(title!, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: SizeConstants.spaceBtwItems),
          Text(subTitle!, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
