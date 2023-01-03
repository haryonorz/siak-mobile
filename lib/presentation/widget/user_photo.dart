import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';

class UserPhoto extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final bool photoPreview;

  const UserPhoto({
    Key? key,
    required this.width,
    required this.height,
    required this.url,
    this.photoPreview = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: photoPreview == true
          ? () => Navigator.pushNamed(
                context,
                Routes.photoPreview,
                arguments: url,
              )
          : null,
      child: url != ''
          ? OctoImage(
              width: width,
              height: height,
              image: CachedNetworkImageProvider(url),
              placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
              errorBuilder: OctoError.icon(color: AppColors.backgroundRed),
              fit: BoxFit.cover,
              imageBuilder: OctoImageTransformer.circleAvatar(),
            )
          : Container(
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
