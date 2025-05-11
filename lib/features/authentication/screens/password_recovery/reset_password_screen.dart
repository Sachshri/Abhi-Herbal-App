import 'package:new_flutter_app/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:new_flutter_app/features/authentication/screens/login/login_screen.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key,required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => Get.back(), icon: Icon(Icons.clear)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizeConstants.defaultSpace),
          child: Column(
            children: [
              // Image for success
              Image(image: AssetImage(ImageStringsConstants.emailVerifyImage)),
              const SizedBox(height: SizeConstants.spaceBtwItems),
              //email
              Text(
                email,
                style:Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,
              ),
              //Title succes
              Text(
                TextStringsConstants.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SizeConstants.spaceBtwItems),
              //Subtitle success
              Text(
                TextStringsConstants.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SizeConstants.spaceBtwSections),
              //Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(()=>const LoginScreen()),
                  child: Text("Done"),
                ),
              ),
          
              //Resend Email
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email),
                  child: Text(TextStringsConstants.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
