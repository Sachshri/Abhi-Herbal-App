import 'package:new_flutter_app/common/styles/common_spacing_style.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    required this.actionName,
  });
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final String actionName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: CommonSpacingStyle.paddingWithAppHeight,
          child: Column(
            children: [
              // Image for success
              Image(image: AssetImage(image)),
              const SizedBox(height: SizeConstants.spaceBtwItems),
              //Title succes
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SizeConstants.spaceBtwItems),
              //Subtitle success
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SizeConstants.spaceBtwSections),
              //Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Text(actionName),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
