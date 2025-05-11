import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class CustomRatingProgressIndicator extends StatelessWidget {
  const CustomRatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });
  final String text;
  final double value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: DeviceUtility.getScreenWidth(context) * 0.8,
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: ColorConstants.grey,
              minHeight: 11,
              borderRadius: BorderRadius.circular(7),
              valueColor: const AlwaysStoppedAnimation(ColorConstants.primary),
            ),
          ),
        ),
      ],
    );
  }
}
