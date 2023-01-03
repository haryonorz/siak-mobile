import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

class LoadingItemNews extends StatelessWidget {
  const LoadingItemNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: 8.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              AppDefaults.sRadius,
            ),
            child: Container(
              width: 80,
              height: 80,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: AppDefaults.lSpace),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.white,
                ),
                const SizedBox(height: AppDefaults.lSpace),
                Container(
                  width: double.infinity,
                  height: 30,
                  color: Colors.white,
                ),
                const SizedBox(height: AppDefaults.lSpace),
                Container(
                  width: 40,
                  height: 10,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
