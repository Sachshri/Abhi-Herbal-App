import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/features/authentication/controllers/signnp/signup_controller.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionCheck extends StatelessWidget {
  const TermsAndConditionCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Obx(() => Checkbox(value: controller.privacyPolicy.value, onChanged: (_) => controller.privacyPolicy.value = !controller.privacyPolicy.value)),  
        ),
        const SizedBox(height: SizeConstants.spaceBtwSections),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${TextStringsConstants.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: '${TextStringsConstants.privacyPolicy} ',
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrl(Uri.parse('https://abhiherbals.netlify.app/')),
                ),
                TextSpan(
                  text: 'and ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: '${TextStringsConstants.termsOfUse}.',
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrl(Uri.parse('https://abhiherbals.netlify.app/')),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
