import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomProfileMenu extends StatelessWidget {
  const CustomProfileMenu({
    super.key,
    this.icon = Iconsax.arrow_right4,
    this.onPressed,
    required this.title,
    required this.value,
    required this.showIcon,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String title, value;
  final bool showIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: SizeConstants.spaceBtwItems / 1.5,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            showIcon?
            Expanded(child: IconButton(icon: Icon(icon),onPressed: onPressed)):Expanded(child:Icon(Icons.check_box,color: ColorConstants.primary,)),
          ],
        ),
      ),
    );
  }
}
