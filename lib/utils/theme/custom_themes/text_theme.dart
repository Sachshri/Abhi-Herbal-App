import 'package:flutter/material.dart';

class CustomTextTheme {
  CustomTextTheme._();

  static final lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 18,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 16,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 14,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w500,
      color: Colors.black.withAlpha(127),
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: 12,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: 16,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.normal,
      color:Colors.black.withAlpha(127),
    ),
  );
  static final darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 18,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 16,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 14,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w500,
      color: Colors.white.withAlpha(127),
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: 12,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: 16,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.normal,
      color: Colors.white.withAlpha(127),
    ),
  );
}
