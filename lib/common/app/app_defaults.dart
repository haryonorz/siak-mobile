import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siak_mobile/common/app/app.dart';

class AppDefaults {
  static const double sRadius = 6;
  static const double mRadius = 10;
  static const double lRadius = 20;
  static const double xlRadius = 30;

  static const double margin = 20;
  static const double padding = 16;

  static const double sSpace = 5;
  static const double mSpace = 8;
  static const double lSpace = 10;
  static const double xlSpace = 20;
  static const double xxlSpace = 30;

  static const double appBarElevation = 2;
  static const double cardElevation = 5;

  //Default Animation Duration
  static const Duration promoDuration = Duration(seconds: 5);
  static const Duration photoPromoDuration = Duration(milliseconds: 500);
  static const Duration membershipDuration = Duration(milliseconds: 500);
  static const Duration dotPromoDuration = Duration(milliseconds: 250);

  static const SystemUiOverlayStyle statusBarTransparent = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );
  static const SystemUiOverlayStyle statusBarWhite = SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  );
  static const SystemUiOverlayStyle statusBarBlack = SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
  );
  static const SystemUiOverlayStyle statusBarGreen = SystemUiOverlayStyle(
    statusBarColor: AppColors.backgroundGreen,
    statusBarIconBrightness: Brightness.light,
  );

  //Divider
  static const sDivider = Divider(height: 1, thickness: 1);
  static const mDivider = Divider(height: 1, thickness: 1.5);
  static const xlDivider = Divider(height: 10, thickness: 10);

  //Iput Border
  static InputBorder border = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.borderLightGrey, width: 1.4),
    borderRadius: BorderRadius.circular(AppDefaults.sRadius),
  );
  static InputBorder enabledBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.borderLightGrey, width: 1.4),
    borderRadius: BorderRadius.circular(AppDefaults.sRadius),
  );
  static InputBorder focusBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.borderGreen, width: 1.6),
    borderRadius: BorderRadius.circular(AppDefaults.sRadius),
  );

  //Shadow
  static BoxShadow boxShadow = BoxShadow(
    color: Colors.black.withOpacity(.2),
    offset: const Offset(
      2.5,
      0.5,
    ),
    blurRadius: 4.0,
    spreadRadius: 0.2,
  );
  static BoxShadow boxShadowInput = BoxShadow(
    color: Colors.black.withOpacity(0.16),
    blurRadius: 4,
    offset: const Offset(2, 4.0),
  );
  static BoxShadow boxShadowBottomBar = BoxShadow(
    blurRadius: 10,
    spreadRadius: 0,
    offset: const Offset(0, 2),
    color: Colors.black.withOpacity(0.15),
  );
}
