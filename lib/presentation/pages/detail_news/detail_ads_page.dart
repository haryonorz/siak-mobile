import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:octo_image/octo_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/presentation/cubit/detail_ads/detail_ads_cubit.dart';
import 'package:siak_mobile/presentation/widget/shimmer/loading_detail_ads.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class DetailAdsPage extends StatefulWidget {
  final String adsId;

  const DetailAdsPage({
    super.key,
    required this.adsId,
  });

  @override
  State<DetailAdsPage> createState() => _DetailAdsPageState();
}

class _DetailAdsPageState extends State<DetailAdsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailAdsCubit>().fetchData(widget.adsId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Detail Iklan'),
        systemOverlayStyle: AppDefaults.statusBarDarkBlue,
      ),
      body: BlocBuilder<DetailAdsCubit, DetailAdsState>(
        builder: (context, state) {
          if (state is DetailAdsLoading) {
            return Shimmer.fromColors(
              baseColor: AppColors.baseColor,
              highlightColor: AppColors.highlightColor,
              enabled: true,
              child: const LoadingDetailAds(),
            );
          } else if (state is DetailAdsHasData) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DetailAdsCubit>().fetchData(widget.adsId);
              },
              child: ListView(
                children: [
                  OctoImage(
                    image: CachedNetworkImageProvider(
                      '${EndPoints.baseUrlPhoto}/iklan/${state.ads.photoCover}',
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
                      state.ads.title,
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
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.clock,
                          size: 16,
                        ),
                        const SizedBox(width: AppDefaults.lSpace),
                        const Text('Periode Promo'),
                        const Spacer(),
                        Text(
                          "${DateFormat('d MMM y').format(state.ads.startDate)}  -  ${DateFormat('d MMM y').format(state.ads.endDate)}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontWeight: FontWeight.w600),
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
                      data: state.ads.content,
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
          } else if (state is DetailAdsError) {
            return ViewError(
              message: state.message,
              showRefresh: true,
              onRefresh: () {
                context.read<DetailAdsCubit>().fetchData(widget.adsId);
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
