import 'package:new_flutter_app/common/styles/common_spacing_style.dart';
import 'package:new_flutter_app/common/widgets/login_signup/form_divider.dart';
import 'package:new_flutter_app/common/widgets/login_signup/social_buttons.dart';
import 'package:new_flutter_app/features/authentication/screens/login/widgets/login_form.dart';
import 'package:new_flutter_app/features/authentication/screens/login/widgets/login_header.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: CommonSpacingStyle.paddingWithAppHeight,
          child: Column(
            children: [
              //Logo and Title Section
              LoginHeader(),
              const SizedBox(height: SizeConstants.spaceBtwSections),
              //Form Section
              LoginForm(),
              const SizedBox(height: SizeConstants.spaceBtwSections),
              //Divider
              FormDivider(
                dividerText: TextStringsConstants.orSignInWith.capitalize!,
              ),
              const SizedBox(height: SizeConstants.spaceBtwSections),
              //Footer
              SocialButtons(),
              const SizedBox(height: SizeConstants.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
