import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak_mobile/common/app/app.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    colorScheme: AppColors.colorScheme,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundBlue,
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom()),
    textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme).apply(
      displayColor: AppColors.textWhite,
      bodyColor: AppColors.textWhite,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(AppDefaults.padding),
        surfaceTintColor: AppColors.buttonActive,
        minimumSize: const Size(double.infinity, 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDefaults.xlRadius),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundDarkBlue,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDefaults.xlRadius),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDefaults.xlRadius),
        borderSide: const BorderSide(color: AppColors.error, width: 1.2),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
    ),
    dialogBackgroundColor: AppColors.backgroundBlue,
  );
}
