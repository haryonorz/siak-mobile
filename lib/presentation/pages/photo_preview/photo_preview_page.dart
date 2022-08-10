import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:siak_mobile/common/app/app.dart';

class PhotoPreviewPage extends StatelessWidget {
  final String? url;

  const PhotoPreviewPage({
    Key? key,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        systemOverlayStyle: AppDefaults.statusBarBlack,
      ),
      body: Center(
        child: url != null
            ? OctoImage(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                image: CachedNetworkImageProvider(url!),
                placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
                errorBuilder: OctoError.icon(color: AppColors.backgroundRed),
                fit: BoxFit.cover,
              )
            : Image.asset(
                AppImages.defaultPhoto,
                width: double.infinity,
              ),
      ),
    );
  }
}
