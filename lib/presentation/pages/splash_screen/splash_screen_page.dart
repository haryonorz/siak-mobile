import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app_images.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.logoStrategis,
          width: 120,
        ),
      ),
    );
  }
}
