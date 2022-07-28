import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF56B161);
  static const Color secondary = Color(0xFF56B161);
  static const Color error = Color(0xFFD6001C);

  //Action Menu
  static const Color actionWhite = Color(0xFFFFFFFF);
  static const Color actionLightGrey = Color(0xFFE5E5E5);

  //Background
  static const Color backgroundDarkGreen = Color(0xFF019267);
  static const Color backgroundDarkGrey = Color(0xFFC4C4C4);
  static const Color bakcgroundDrakYellow = Color(0xFFEBD671);
  static const Color backgroundGreen = Color(0xFF56B161);
  static const Color backgroundGrey = Color(0xFFE2E2E2);
  static const Color bakcgroundLightBlue = Color(0xFFF0F4F7);
  static const Color bakcgroundLightCream = Color(0xFFFFF2E2);
  static const Color bakcgroundLightCyan = Color(0xFFEBFAF0);
  static const Color bakcgroundLightGreen = Color(0xFFECF8EF);
  static const Color bakcgroundLightGrey = Color(0xFFF1F1F1);
  static const Color bakcgroundOrange = Color(0xFFFFD365);

  //Button
  static const Color buttonActive = Color(0xFF56B161);
  static const Color buttonNonActive = Color(0xFFC7C7C7);

  //Border
  static const Color borderDarkCream = Color(0xFFE8D3BA);
  static const Color borderDarkGreen = Color(0xFF019267);
  static const Color borderGreen = Color(0xFF56B161);
  static const Color borderLightGrey = Color(0xFFCCCCCC);

  //Chart
  static const Color borderLineChart = Color(0xFFA6A6A6);
  static const Color pieChartYellow = Color(0xFFFFC000);
  static const Color pieChartBlue = Color(0xFF26A0FC);
  static const Color pieChartCyan = Color(0xFF68D4CD);

  //Dot
  static const Color dotGrey = Color(0xFFC4C4C4);

  //Gradient
  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF57B262),
      Color(0xFF52AA5D),
      Color(0xFF489B52),
    ],
  );

  //Hint
  static const Color hint = Color(0xFFCCCCCC);

  //Icon
  static const Color iconBlack = Color(0xFF3D3D3D);
  static const Color iconDarkGrey = Color(0xFF6F6F6F);

  //Radio
  static const Color radioDarkGreen = Color(0xFF019267);

  //Text
  static const Color textBlack = Color(0xFF505050);
  static const Color textDarkBlack = Color(0xFF3F3F3F);
  static const Color textDarkGreen = Color(0xFF019267);
  static const Color textDarkGrey = Color(0xFF6F6F6F);
  static const Color textGreen = Color(0xFF56B161);
  static const Color textGrey = Color(0xFF8E8E8E);
  static const Color textLightGrey = Color(0xFFA4A4A4);
  static const Color textLightRed = Color(0xFFCD6A6A);

  //Theme
  static const colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.white,
    secondary: secondary,
    onSecondary: textDarkGrey,
    error: error,
    onError: Colors.white,
    background: Colors.white,
    onBackground: textDarkGrey,
    surface: Colors.white,
    onSurface: textDarkGrey,
  );
}
