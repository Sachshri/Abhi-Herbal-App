import 'package:new_flutter_app/common/styles/common_spacing_style.dart';
import 'package:new_flutter_app/common/widgets/login_signup/form_divider.dart';
import 'package:new_flutter_app/common/widgets/login_signup/social_buttons.dart';
import 'package:new_flutter_app/features/authentication/screens/signup/widgets/sign_up_form.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: CommonSpacingStyle.paddingWithAppHeight,
          child: Column(
            children: [
              Text(
                TextStringsConstants.createAccount,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: SizeConstants.spaceBtwSections),
              //Singup Form
              const SignUpForm(),
              //Divider
              FormDivider(
                dividerText: TextStringsConstants.orSignUpWith.capitalize!,
              ),
              const SizedBox(height: SizeConstants.spaceBtwItems),
              //Social Buttons
              const SocialButtons(),
              const SizedBox(height: SizeConstants.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
