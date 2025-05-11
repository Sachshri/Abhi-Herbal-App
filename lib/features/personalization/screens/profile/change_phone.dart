import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/features/personalization/controllers/update_phone_controller.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/constants/text_strings.dart';
import 'package:new_flutter_app/utils/validators/validators.dart';

class ChangePhone extends StatelessWidget {
  const ChangePhone({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneController());
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          "Change Phone Number",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(SizeConstants.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Heading
            Text(
              'Use real number for easy verification. This number will be used to contact you.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: SizeConstants.spaceBtwSections),

            //Text Field and Button
            Form(
              key: controller.updatePhoneFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: //phone number
                    TextFormField(
                      validator: (value) => Validators.phoneNumberValidator(value),
                      controller: controller.phoneNumber,
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TextStringsConstants.phoneNo,
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
            ),

            const SizedBox(height: SizeConstants.spaceBtwSections),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updatePhoneNumber(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}