import 'package:new_flutter_app/common/styles/common_spacing_style.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/features/authentication/controllers/signnp/verify_email_controller.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
            icon: Icon(Icons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: CommonSpacingStyle.paddingWithAppHeight,
        child: Column(
          children: [
            //Image
            Image(image: AssetImage(ImageStringsConstants.emailVerifyImage)),
            const SizedBox(height: SizeConstants.spaceBtwItems),
            //Title and Subtitle
            Text(
              TextStringsConstants.confirmEmail,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: SizeConstants.spaceBtwItems),
            //Subtitle
            Text(
              email??"",
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: SizeConstants.spaceBtwItems),
            Text(
              TextStringsConstants.confirmEmailSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: SizeConstants.spaceBtwSections),
            //Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    () => controller.checkEmailVerificationStatus(),
                child: Text("Continue"),
              ),
            ),
            const SizedBox(height: SizeConstants.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              //Resend Email
              child: TextButton(
                onPressed: ()=>controller.sendEmailVerification(),
                child: Text(TextStringsConstants.resendEmail),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
