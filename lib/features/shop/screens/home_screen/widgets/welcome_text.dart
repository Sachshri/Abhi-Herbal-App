import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
    required this.welcomeText,
    required this.welcomeTo,
  });

  final String welcomeText;
  final String welcomeTo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SizeConstants.md),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: welcomeText,
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            TextSpan(
              text: welcomeTo,
              style: Theme.of(context).textTheme.headlineMedium!.apply(
                color: const Color.fromARGB(180, 3, 16, 255),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
