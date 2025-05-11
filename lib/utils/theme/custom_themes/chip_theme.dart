import 'package:flutter/material.dart';

class CustomChipTheme {
  CustomChipTheme._();

  static final lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withAlpha(102),
    labelStyle: TextStyle(
      color: Colors.black,
    ),
    selectedColor: Colors.green,
    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
    checkmarkColor: Colors.white,
  );
  static final darkChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withAlpha(102),
    labelStyle: TextStyle(
      color: Colors.white,
    ),
    selectedColor: Colors.green,
    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
    checkmarkColor: Colors.black,
  );
}
