import 'package:flutter/material.dart';

abstract final class AppColors {
  static const black1 = Color(0xFF101010);
  static const white1 = Color(0xFFFFF7FA);
  static const grey1 = Color(0xFFF2F2F2);
  static const grey2 = Color(0xFF4D4D4D);
  static const grey3 = Color(0xFFA4A4A4);
  static const appBlue = Color(0xFF2194F2);
  static const whiteTransparent = Color(
    0x4DFFFFFF,
  ); // Figma rgba(255, 255, 255, 0.3)
  static const blackTransparent = Color(0x4D000000);
  static const red1 = Color(0xFFE74C3C);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.appBlue,
    onPrimary: Colors.white,
    primaryContainer: appBlue,
    onPrimaryContainer: Colors.white,
    secondary: AppColors.white1,
    onSecondary: AppColors.appBlue,
    surface: Colors.white,
    onSurface: AppColors.black1,
    error: Colors.red,
    onError: Colors.white,
    outline: AppColors.appBlue,
    secondaryContainer: AppColors.white1,
    onSecondaryContainer: AppColors.appBlue,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: appBlue,
    onPrimary: Colors.white,
    secondary: grey1,
    onSecondary: AppColors.black1,
    surface: AppColors.black1,
    onSurface: grey3,
    outline: AppColors.appBlue,
    error: Colors.black,
    onError: AppColors.red1,
    secondaryContainer: Color.fromARGB(255, 33, 33, 33),
    onSecondaryContainer: AppColors.appBlue,
  );
}
