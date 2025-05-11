import 'package:new_flutter_app/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/utils/validators/validators.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => Get.back(), icon: Icon(Icons.clear)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(SizeConstants.defaultSpace),
        child: Column(
          children: [
            //Headings
            Text(
              TextStringsConstants.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: SizeConstants.spaceBtwItems),
            Text(
              TextStringsConstants.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: SizeConstants.spaceBtwSections),
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
              controller: controller.email,
              validator: Validators.emailValidator,
              decoration: InputDecoration(
                labelText: TextStringsConstants.email,
                prefixIcon: Icon(Icons.email),
              ),
            ),
            ),
            
            const SizedBox(height: SizeConstants.spaceBtwSections * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.sendPasswordResetEmail(),
                child: Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
