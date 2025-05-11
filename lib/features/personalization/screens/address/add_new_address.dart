import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/features/personalization/controllers/address_controller.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_flutter_app/utils/validators/validators.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Add New Address',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConstants.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) => Validators.validateEmptyText("Name", value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: SizeConstants.spaceBtwInputField),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value)=>Validators.phoneNumberValidator(value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(height: SizeConstants.spaceBtwInputField),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value)=>Validators.validateEmptyText("Street", value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'Street',
                        ),
                      ),
                    ),
                    const SizedBox(width: SizeConstants.spaceBtwInputField),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value)=>Validators.validateEmptyText("Postal Code", value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SizeConstants.spaceBtwInputField),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value)=>Validators.validateEmptyText("City", value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'City',
                        ),
                      ),
                    ),
                    const SizedBox(width: SizeConstants.spaceBtwInputField),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value)=>Validators.validateEmptyText("State", value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: 'State',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SizeConstants.defaultSpace),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: ()=>controller.addNewAddress(), child: Text('Save')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
