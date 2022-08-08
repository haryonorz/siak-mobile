import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:siak_mobile/common/app/app.dart';

class UserPhoto extends StatelessWidget {
  final double width;
  final double height;
  final String url;

  const UserPhoto({
    Key? key,
    required this.width,
    required this.height,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      width: width,
      height: height,
      image: CachedNetworkImageProvider(url),
      placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
      errorBuilder: OctoError.icon(color: AppColors.backgroundRed),
      fit: BoxFit.cover,
      imageBuilder: OctoImageTransformer.circleAvatar(),
    );
  }
}
