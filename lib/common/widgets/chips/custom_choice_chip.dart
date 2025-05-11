import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_circular_container.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomChoiceChip extends StatelessWidget {
  const CustomChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;
  @override
  Widget build(BuildContext context) {
    final isColor = HelperFunctions.getColor(text) != null;
    return Padding(
      padding: const EdgeInsets.all(SizeConstants.sm),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? ColorConstants.white : null),
        avatar:
            isColor
                ? CustomCircularContainer(
                  radius: 50,
                  width: 50,
                  height: 50,
                  color: Colors.green,
                )
                : null,
        // shape: CircleBorder(),
        labelPadding: isColor ? EdgeInsets.all(0) : null,
        padding: isColor ? const EdgeInsets.all(0) : null,
        selectedColor: isColor ? Colors.green : null,
        backgroundColor: isColor ? HelperFunctions.getColor(text)! : null,
      ),
    );
  }
}
