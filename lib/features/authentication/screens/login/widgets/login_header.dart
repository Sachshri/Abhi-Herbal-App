import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: AssetImage(ImageStringsConstants.logo), height: 150),
        //loginTitle
        Text(
          TextStringsConstants.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: SizeConstants.sm),
        //Login subtitle
        Text(
          TextStringsConstants.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
