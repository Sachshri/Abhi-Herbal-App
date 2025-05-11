import 'package:flutter/material.dart';

class SectionHeadingWithButton extends StatelessWidget {
  const SectionHeadingWithButton({
    super.key,
    this.isButtonVisible = false,
    required this.sectionHeading,
    this.buttonText = "View All",
    this.onPressed,
    this.textColor
  });

  final bool isButtonVisible;
  final String sectionHeading;
  final void Function()? onPressed;
  final String buttonText;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionHeading,
          style: Theme.of(context).textTheme.headlineSmall!.apply(
                color: textColor,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (isButtonVisible)
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: Theme.of(context).textTheme.bodySmall!.apply(
                    color: const Color.fromARGB(180, 3, 255, 3),
                  ),
            ),
          ),
      ],
    );
  }
}
