import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFec1e22);
  static const Color secondary = Color(0xFFec1e22);
  static const Color error = Color(0xFFD6001C);

  //Action Menu
  static const Color actionWhite = Color(0xFFFFFFFF);
  static const Color actionLightGrey = Color(0xFFE5E5E5);

  //Background
  static const Color backgroundDarkBlue = Color(0xFF0F173E);
  static const Color backgroundBlue = Color(0xFF0b2a60);
  static const Color backgroundLightBlue = Color(0xFF253E98);
  static const Color backgroundRed = Color(0xFFec1e22);
  static const Color backgroundGrey = Color(0xFFE2E2E2);
  static const Color backgroundLightGrey = Color(0xFFCCCCCC);

  //Button
  static const Color buttonActive = Color(0xFFec1e22);
  static const Color buttonNonActive = Color(0xFFC7C7C7);

  //Border
  static const Color borderRed = Color(0xFFec1e22);
  static const Color borderLightGrey = Color(0xFFCCCCCC);

  //Hint
  static const Color hint = Color(0xFFCDCFD8);

  //Icon
  static const Color iconWhite = Color(0xFFFFFFFF);
  static const Color iconGrey = Color(0xFF70778E);
  static const Color iconRed = Color(0xFFec1e22);

  //Text
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGrey = Color(0xFFCDCFD8);
  static const Color textRed = Color(0xFFec1e22);
  static const Color textGreen = Color(0xFF56B161);
  static const Color textYellow = Color(0xFFFFC000);

  //Theme
  static const colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: Colors.white,
    secondary: secondary,
    onSecondary: textWhite,
    error: error,
    onError: Colors.white,
    background: backgroundBlue,
    onBackground: textWhite,
    surface: backgroundDarkBlue,
    onSurface: textWhite,
  );
}
