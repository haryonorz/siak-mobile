import 'package:siak_mobile/common/routes.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:octo_image/octo_image.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/domain/entities/news.dart';

class ItemNews extends StatelessWidget {
  final News news;

  const ItemNews({super.key, required this.news});

  String? _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: 8.0,
      ),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          Routes.detailNews,
          arguments: news.newsId,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                AppDefaults.sRadius,
              ),
              child: OctoImage(
                width: 80,
                height: 80,
                image: CachedNetworkImageProvider(
                  '${EndPoints.baseUrlPhoto}/news/${news.photoCover}',
                ),
                placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
                errorBuilder: OctoError.icon(color: AppColors.backgroundRed),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: AppDefaults.lSpace),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppDefaults.sSpace),
                  Text(
                    _parseHtmlString(news.content) ?? "-",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: AppColors.textGrey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppDefaults.sSpace),
                  Text(
                    timeago.format(news.addate),
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
