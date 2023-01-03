import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:octo_image/octo_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/presentation/cubit/detail_news/detail_news_cubit.dart';
import 'package:siak_mobile/presentation/widget/shimmer/loading_detail_ads.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class DetailNewsPage extends StatefulWidget {
  final String newsId;

  const DetailNewsPage({
    super.key,
    required this.newsId,
  });

  @override
  State<DetailNewsPage> createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailNewsCubit>().fetchData(widget.newsId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Detail News'),
        systemOverlayStyle: AppDefaults.statusBarDarkBlue,
      ),
      body: BlocBuilder<DetailNewsCubit, DetailNewsState>(
        builder: (context, state) {
          if (state is DetailNewsLoading) {
            return Shimmer.fromColors(
              baseColor: AppColors.baseColor,
              highlightColor: AppColors.highlightColor,
              enabled: true,
              child: const LoadingDetailAds(),
            );
          } else if (state is DetailNewsHasData) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DetailNewsCubit>().fetchData(widget.newsId);
              },
              child: ListView(
                children: [
                  OctoImage(
                    image: CachedNetworkImageProvider(
                      '${EndPoints.baseUrlPhoto}/news/${state.news.photoCover}',
                    ),
                    placeholderBuilder:
                        OctoPlaceholder.circularProgressIndicator(),
                    errorBuilder:
                        OctoError.icon(color: AppColors.backgroundRed),
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppDefaults.padding),
                    child: Text(
                      state.news.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.padding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.user,
                          size: 16,
                        ),
                        const SizedBox(width: AppDefaults.lSpace),
                        Text(
                          state.news.addby,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: AppDefaults.xlSpace),
                        Text(
                          timeago.format(state.news.addate),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDefaults.xlSpace),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: AppColors.backgroundDarkBlue,
                  ),
                  const SizedBox(height: AppDefaults.sSpace),
                  Padding(
                    padding: const EdgeInsets.all(
                      AppDefaults.padding,
                    ),
                    child: Html(
                      data: state.news.content,
                      style: {
                        "html": Style(
                          fontSize: const FontSize(16),
                        ),
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DetailNewsError) {
            return ViewError(
              message: state.message,
              showRefresh: true,
              onRefresh: () {
                context.read<DetailNewsCubit>().fetchData(widget.newsId);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
