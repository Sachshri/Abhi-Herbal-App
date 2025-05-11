import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/features/personalization/controllers/user_controller.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:new_flutter_app/utils/validators/validators.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: const Text('Re-Authenticate User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizeConstants.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: Validators.emailValidator,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: TextStringsConstants.email,
                  ),
                ),
                const SizedBox(height: SizeConstants.spaceBtwInputField),
                //Password
                TextFormField(
                  controller: controller.verifyPassword,
                  validator: Validators.validatePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    labelText: TextStringsConstants.password,
                    suffixIcon: Obx(
                      () => IconButton(
                        onPressed: () => controller.hidePassword.value=!controller.hidePassword.value,
                        icon: controller.hidePassword.value? const Icon(Iconsax.eye_slash):const Icon(Iconsax.eye),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: SizeConstants.spaceBtwSections),
                //Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        () => controller.reAuthenticateEmailAndPasswordUser(),
                    child: const Text("Verify"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
