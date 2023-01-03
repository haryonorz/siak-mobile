import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/widget/shimmer/loading_item_news.dart';

class LoadingHome extends StatelessWidget {
  const LoadingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
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
                alignment: Alignment.bottomCenter,
                child: Shimmer.fromColors(
                  baseColor: AppColors.baseColor,
                  highlightColor: AppColors.highlightColor,
                  enabled: true,
                  child: Container(
                    width: double.infinity,
                    height: 125.0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.margin,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppDefaults.sRadius,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Shimmer.fromColors(
          baseColor: AppColors.baseColor,
          highlightColor: AppColors.highlightColor,
          enabled: true,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                5,
                (index) => Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: AppDefaults.lSpace,
                    ),
                    Container(
                      width: 40,
                      height: 14,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Shimmer.fromColors(
          baseColor: AppColors.baseColor,
          highlightColor: AppColors.highlightColor,
          enabled: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 60,
                      height: 14,
                      color: Colors.white,
                    ),
                    Container(
                      width: 40,
                      height: 10,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppDefaults.lSpace,
              ),
            ],
          ),
        ),
        Expanded(
          child: Shimmer.fromColors(
            baseColor: AppColors.baseColor,
            highlightColor: AppColors.highlightColor,
            enabled: true,
            child: Column(
              children: List.generate(3, (index) => const LoadingItemNews()),
            ),
          ),
        ),
      ],
    );
  }
}
