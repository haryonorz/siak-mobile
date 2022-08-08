import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

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
    return Image.asset(
      AppImages.defaultPhoto,
      width: width,
      height: height,
    );
  }
}
