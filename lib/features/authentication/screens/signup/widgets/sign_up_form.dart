import 'package:new_flutter_app/features/authentication/controllers/signnp/signup_controller.dart';
import 'package:new_flutter_app/features/authentication/screens/signup/widgets/terms_and_condition_check.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_flutter_app/utils/validators/validators.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          //First and Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator:
                      (value) =>
                          Validators.validateEmptyText('First name', value),
                  controller: controller.firstName,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TextStringsConstants.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: SizeConstants.spaceBtwInputField),
              Expanded(
                child: TextFormField(
                  validator:
                      (value) =>
                          Validators.validateEmptyText('Last name', value),
                  controller: controller.lastName,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TextStringsConstants.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: SizeConstants.spaceBtwInputField),
          //UserName
          TextFormField(
            validator:
                (value) => Validators.validateEmptyText('Username', value),
            controller: controller.username,
            expands: false,
            decoration: const InputDecoration(
              labelText: TextStringsConstants.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: SizeConstants.spaceBtwInputField),
          //Email
          TextFormField(
            validator: (value) => Validators.emailValidator(value),
            controller: controller.email,
            expands: false,
            decoration: const InputDecoration(
              labelText: TextStringsConstants.email,
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(height: SizeConstants.spaceBtwInputField),
          //phone number
          TextFormField(
            validator: (value) => Validators.phoneNumberValidator(value),
            controller: controller.phoneNumber,
            expands: false,
            decoration: const InputDecoration(
              labelText: TextStringsConstants.phoneNo,
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          const SizedBox(height: SizeConstants.spaceBtwInputField),
          //passoword
          Obx(
            () => TextFormField(
              validator: (value) => Validators.validatePassword(value),
              controller: controller.password,
              expands: false,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: TextStringsConstants.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed:
                      () =>
                          controller.hidePassword.value =
                              !controller.hidePassword.value,
                  icon: Obx(
                    () => Icon(
                      controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: SizeConstants.spaceBtwSections),
          //CheckBox Terms and contidion
          const TermsAndConditionCheck(),
          const SizedBox(height: SizeConstants.spaceBtwItems),
          //Signup Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signUp(),
              child: Text(TextStringsConstants.createAccount),
            ),
          ),
          const SizedBox(height: SizeConstants.spaceBtwSections),
        ],
      ),
    );
  }
}
