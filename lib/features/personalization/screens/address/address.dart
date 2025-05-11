import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/features/personalization/controllers/address_controller.dart';
import 'package:new_flutter_app/features/personalization/screens/address/add_new_address.dart';
import 'package:new_flutter_app/features/personalization/screens/address/widgets/single_address.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_flutter_app/utils/helpers/cloud_helper_function.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =AddressController.instance;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: ColorConstants.primary,
        child: const Icon(Iconsax.add, color: ColorConstants.white),
      ),
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          "Addresses",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizeConstants.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.allUserAddresses(),
              builder: (context, snapshot) {
                final widget = CustomCloudHelperFunction.checkMultiRecordState(
                  snapshot: snapshot,
                );
                if (widget != null) return widget;

                final addresses = snapshot.data!;

                return ListView.builder(
                  itemCount: addresses.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CustomSingleAddress(
                      address: addresses[index],
                      onTap: () => controller.selectAddress(addresses[index]),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
