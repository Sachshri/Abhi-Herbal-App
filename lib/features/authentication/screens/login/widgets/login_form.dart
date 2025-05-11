import 'package:new_flutter_app/features/authentication/controllers/login/login_controller.dart';
import 'package:new_flutter_app/features/authentication/screens/password_recovery/forget_password_screen.dart';
import 'package:new_flutter_app/features/authentication/screens/signup/sign_up_screen.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_flutter_app/utils/validators/validators.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: SizeConstants.spaceBtwSections,
        ),
        child: Column(
          //Enter Email
          children: [
            TextFormField(
              validator: (value) => Validators.emailValidator(value),
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: TextStringsConstants.email,
                // labelStyle: TextStyle(fontSize: SizeConstants.fontSizeSm),
              ),
            ),
            const SizedBox(height: SizeConstants.spaceBtwInputField / 2),

            //Password
            Obx(
              () => TextFormField(
                validator: (value) => Validators.validatePassword(value),
                controller: controller.password,
                obscureText: !controller.hidePassword.value,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: TextStringsConstants.password,
                  // labelStyle:const TextStyle(fontSize: SizeConstants.fontSizeSm),
                  suffixIcon: InkWell(
                    onTap: controller.toggleVisibility,
                    child:
                        controller.hidePassword.value
                            ? Icon(Iconsax.eye)
                            : Icon(Iconsax.eye_slash),
                  ),
                ),
              ),
            ),
            // Remember me and forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Row(
                    children: [
                  Obx(
                    () =>Checkbox(
                        value: controller.rememberMe.value,
                        onChanged:
                            (_) =>
                                controller.rememberMe.value =
                                    !controller.rememberMe.value,
                      ),
                      ),
                      const Text(TextStringsConstants.rememberMe),
                    ],
                  ),
                
                //forget password
                TextButton(
                  onPressed: () => Get.to(() => ForgetPasswordScreen()),
                  child: Text(TextStringsConstants.forgetPassword),
                ),
              ],
            ),
            //SignIn button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.login(),
                child: Text(TextStringsConstants.signIn),
              ),
            ),
            const SizedBox(height: SizeConstants.spaceBtwItems),
            //Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => SignUpScreen()),
                child: Text(TextStringsConstants.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
