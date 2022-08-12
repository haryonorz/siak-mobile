import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';

class DefaultUserPhoto extends StatelessWidget {
  final double width;
  final double height;
  final bool photoPreview;

  const DefaultUserPhoto({
    Key? key,
    required this.width,
    required this.height,
    this.photoPreview = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: photoPreview == true
          ? () => Navigator.pushNamed(context, Routes.photoPreview)
          : null,
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(
              AppImages.defaultPhoto,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
