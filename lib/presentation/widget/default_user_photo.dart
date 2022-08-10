import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';

class DefaultUserPhoto extends StatelessWidget {
  final double width;
  final double height;

  const DefaultUserPhoto({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.photoPreview),
      child: Image.asset(
        AppImages.defaultPhoto,
        width: width,
        height: height,
      ),
    );
  }
}
