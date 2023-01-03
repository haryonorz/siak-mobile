import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/domain/entities/ads.dart';

class HomeAds extends StatelessWidget {
  final List<Ads> adList;

  const HomeAds({Key? key, required this.adList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                AppImages.backgroundHomeTop,
                width: double.infinity,
              ),
              const SizedBox(height: 75),
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 125.0,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  viewportFraction: .94,
                ),
                items: adList.map((i) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.detailAds,
                      arguments: i.adsId,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppDefaults.sSpace,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppDefaults.sRadius,
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            '${EndPoints.baseUrlPhoto}/iklan/${i.photoCover}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
