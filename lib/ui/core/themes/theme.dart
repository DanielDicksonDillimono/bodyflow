import 'package:bodyflow/ui/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static final textTheme = TextTheme(
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    labelLarge: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.normal),
    labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    headlineLarge: GoogleFonts.openSans(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
    displayLarge: GoogleFonts.poppins(
      fontSize: 57,
      fontWeight: FontWeight.w900,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: AppTheme.textTheme,
    colorScheme: AppColors.lightColorScheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        backgroundColor: AppColors.appBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grey1,
      prefixIconColor: AppColors.appBlue,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      errorStyle: TextStyle(color: Colors.red),
      hintStyle: TextStyle(color: AppColors.grey3),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    textTheme: AppTheme.textTheme,
    colorScheme: AppColors.darkColorScheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        backgroundColor: AppColors.appBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: AppColors.grey2),
      prefixIconColor: AppColors.appBlue,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      errorStyle: TextStyle(color: Colors.red),
      hintStyle: TextStyle(color: AppColors.grey3),
    ),

    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
