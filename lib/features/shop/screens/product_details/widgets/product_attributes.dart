import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/chips/custom_choice_chip.dart';
import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/common/widgets/custom_text/custom_product_title_text.dart';
import 'package:new_flutter_app/common/widgets/custom_text/product_price_text.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/section_heading_with_button.dart';
import 'package:new_flutter_app/features/shop/controllers/product_controller/variation_controller.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/enums.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomProductAttributes extends StatelessWidget {
  const CustomProductAttributes({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = HelperFunctions.isDarkMode(context);
    return Obx(
      () => Column(
        children: [
          if (controller.selectedVariation.value.id.isNotEmpty)
            CustomRoundedContainer(
              padding: EdgeInsets.all(SizeConstants.defaultSpace),
              backgroundColor:
                  dark ? ColorConstants.darkerGrey : ColorConstants.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SectionHeadingWithButton(
                        sectionHeading:
                            controller.selectedVariation.value.attributeValues.toString().replaceAll('{', '').replaceAll('}', ''),
                        isButtonVisible: false,
                      ),
                      SizedBox(width: SizeConstants.spaceBtwItems),
                      Column(
                        children: [
                          Row(
                            children: [
                              const CustomProductTitleText(
                                title: 'Price: ',
                                smallSize: true,
                              ),
                              const SizedBox(
                                width: SizeConstants.spaceBtwItems,
                              ),
                              //Actual Price
                              if (product.productType ==
                                      ProductType.single.toString() &&
                                  product.salePrice! > 0)
                                Text(
                                  '\u20B9${controller.selectedVariation.value.price}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall!.apply(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              if (product.productType ==
                                      ProductType.single.toString() &&
                                  product.salePrice! > 0)
                                const SizedBox(
                                  width: SizeConstants.spaceBtwItems,
                                ),

                              //Sale Price
                              CustomProductPriceText(
                                price: controller.getVariationPrice(),
                              ),
                            ],
                          ),
                          //Stock
                          Row(
                            children: [
                              const CustomProductTitleText(
                                title: 'Availability: ',
                                smallSize: true,
                              ),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  //variation Desc
                  CustomProductTitleText(
                    title: '${controller.selectedVariation.value.description}',
                    smallSize: true,
                    maxLines: 6,
                  ),
                ],
              ),
            ),
          const SizedBox(height: SizeConstants.spaceBtwItems),

          // Attributes
          Column(
            children:
                product.productAttributes!
                    .map(
                      (attribute) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeadingWithButton(
                            sectionHeading: '${attribute.name}',
                            isButtonVisible: false,
                          ),
                          SizedBox(height: SizeConstants.spaceBtwItems / 2),
                          Obx(
                            () => Wrap(
                              children:
                                  attribute.values!.map((attributeValue) {
                                    final isSelected =
                                        controller.selectedAttributes[attribute
                                            .name] ==
                                        attributeValue;
                                    final available = controller
                                        .getAttributesAvailabilityInVariation(
                                          product.productVariations!,
                                          attribute.name!,
                                        )
                                        .contains(attributeValue);
                                    return CustomChoiceChip(
                                      text: attributeValue,
                                      selected: isSelected,
                                      onSelected:
                                          available
                                              ? (selected) {
                                                if (selected && available) {
                                                  controller
                                                      .onAttributeSelected(
                                                        product,
                                                        attribute.name ?? '',
                                                        attributeValue,
                                                      );
                                                }
                                              }
                                              : null,
                                    );
                                  }).toList(),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
