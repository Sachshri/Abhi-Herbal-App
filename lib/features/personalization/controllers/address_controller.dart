import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/section_heading_with_button.dart';
import 'package:new_flutter_app/common/widgets/loaders/circular_loader.dart';
import 'package:new_flutter_app/data/repositories/address/address_repository.dart';
import 'package:new_flutter_app/features/personalization/models/address_model.dart';
import 'package:new_flutter_app/features/personalization/screens/address/add_new_address.dart';
import 'package:new_flutter_app/features/personalization/screens/address/widgets/single_address.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/cloud_helper_function.dart';
import 'package:new_flutter_app/utils/helpers/network_manager.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';
import 'package:new_flutter_app/utils/popups/full_screen_loader.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final state = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  final refreshData = true.obs;

  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  Future<List<AddressModel>> allUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: 'Address not found',
        message: e.toString(),
      );
      return [];
    }
  }

  Future selectAddress(AddressModel address) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async {
          return false;
        },
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const CustomCircularLoader(),
      );
      // clear seleted address field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
          selectedAddress.value.id,
          false,
        );
      }
      address.selectedAddress = true;
      selectedAddress.value = address;
      await addressRepository.updateSelectedField(
        selectedAddress.value.id,
        true,
      );

      Get.back();
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: "Error in Selection!",
        message: e.toString(),
      );
    }
  }

  Future addNewAddress() async {
    try {
      CustomFullScreenLoader.openLoadingDialog(
        'Adding New Address...',
        'assets/animations/loading.gif',
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullScreenLoader.closeLoadingDialog();
        return;
      }

      //Form Validation
      if (!addressFormKey.currentState!.validate()) {
        CustomFullScreenLoader.closeLoadingDialog();
        return;
      }

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        country: country.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address);
      address.id = id;
      await selectAddress(address);

      CustomFullScreenLoader.closeLoadingDialog();

      CustomLoaders.successSnackBar(
        title: 'Success!',
        message:
            "Your new address has been saved. You can now use it for orders!",
      );
      refreshData.toggle();
      resetFromFields();
      Navigator.of(Get.context!).pop();
    } catch (e) {
      CustomFullScreenLoader.closeLoadingDialog();
      CustomLoaders.errorSnackBar(
        title: 'Something Went Wrong!',
        message: e.toString(),
      );
    }
  }

  void resetFromFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    city.clear();
    country.clear();
    state.clear();
    postalCode.clear();
    addressFormKey.currentState?.reset();
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder:
          (_) => SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(SizeConstants.lg),
              child: Column(
                children: [
                  const SectionHeadingWithButton(
                    sectionHeading: 'Select Address',
                    isButtonVisible: false,
                  ),
                  FutureBuilder(
                    future: allUserAddresses(),
                    builder: (_, snapshot) {
                      final response =
                          CustomCloudHelperFunction.checkMultiRecordState(
                            snapshot: snapshot,
                          );
                      if (response != null) return response;
            
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) {
                          return CustomSingleAddress(
                            address: snapshot.data![index],
                            onTap: () async {
                              selectedAddress(snapshot.data![index]);
                              Get.back();
                            },
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: SizeConstants.defaultSpace*2,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: ()=> Get.to(()=> const AddNewAddressScreen()),
                     child: const Text('Add new Address')),
                  )
                ],
              ),
            ),
          ),
    );
  }
}
