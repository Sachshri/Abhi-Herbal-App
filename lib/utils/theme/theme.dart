import 'package:new_flutter_app/utils/theme/custom_themes/app_bar_theme.dart';
import 'package:new_flutter_app/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:new_flutter_app/utils/theme/custom_themes/check_box_theme.dart';
import 'package:new_flutter_app/utils/theme/custom_themes/chip_theme.dart';
import 'package:new_flutter_app/utils/theme/custom_themes/elevated_button_theme_data.dart';
import 'package:new_flutter_app/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:new_flutter_app/utils/theme/custom_themes/text_field_theme.dart';
import 'package:new_flutter_app/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class CustomAppTheme {
  CustomAppTheme._();
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: "Montserrat",
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    textTheme: CustomTextTheme.lightTextTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: CustomCheckBoxTheme.lightCheckBoxTheme,
    chipTheme: CustomChipTheme.lightChipTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: CustomTextFieldTheme.lightInputDecorationTheme,
  );
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: "Montserrat",
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.black,
    textTheme: CustomTextTheme.darkTextTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: CustomCheckBoxTheme.darkCheckBoxTheme,
    chipTheme: CustomChipTheme.darkChipTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: CustomTextFieldTheme.darkInputDecorationTheme,
  );
}
