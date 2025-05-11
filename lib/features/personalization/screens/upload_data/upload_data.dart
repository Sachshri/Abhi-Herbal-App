import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/upload_data_controller.dart';
import 'package:new_flutter_app/features/shop/screens/article/write_article.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';

class UploadDataScreen extends StatelessWidget {
  const UploadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadDataController());
    return  Scaffold(
      appBar: CustomAppBar(title: Text("Load Data"), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(SizeConstants.defaultSpace),
        child: Column(
          children: [
            CustomRoundedContainer(
              padding: const EdgeInsets.all(SizeConstants.defaultSpace/2),
              showBorder: true,
              backgroundColor: HelperFunctions.isDarkMode(context)?const Color.fromRGBO(66, 66, 66, 1):Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Upload Product'),
                  IconButton(onPressed:controller.uploadProducts, icon: Icon(Iconsax.document_upload,color: ColorConstants.primary,)),
                ],
              ),
            ),
            const SizedBox(height: SizeConstants.spaceBtwItems),
            CustomRoundedContainer(
              padding: const EdgeInsets.all(SizeConstants.defaultSpace/2),
              showBorder: true,
              backgroundColor: HelperFunctions.isDarkMode(context)?const Color.fromRGBO(66, 66, 66, 1):Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Upload Banners'),
                  IconButton(onPressed:()=>controller.uploadBanners(), icon: Icon(Iconsax.document_upload,color: ColorConstants.primary,)),
                ],
              ),
            ),
            const SizedBox(height: SizeConstants.spaceBtwItems),
            CustomRoundedContainer(
              padding: const EdgeInsets.all(SizeConstants.defaultSpace/2),
              showBorder: true,
              backgroundColor: HelperFunctions.isDarkMode(context)?const Color.fromRGBO(66, 66, 66, 1):Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Upload Category'),
                  IconButton(onPressed: ()=>controller.uploadCategory(), icon: Icon(Iconsax.document_upload,color: ColorConstants.primary,)),
                ],
              ),
            ),
            const SizedBox(height: SizeConstants.spaceBtwItems),
            CustomRoundedContainer(
              padding: const EdgeInsets.all(SizeConstants.defaultSpace/2),
              showBorder: true,
              backgroundColor: HelperFunctions.isDarkMode(context)?const Color.fromRGBO(66, 66, 66, 1):Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Write Article'),
                  IconButton(onPressed: ()=>Get.to(WriteArticleScreen()), icon: Icon(Icons.abc,color: ColorConstants.primary,)),
                ],
              ),
            ),
            const SizedBox(height: SizeConstants.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
