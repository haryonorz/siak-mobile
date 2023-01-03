import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

class LoadingDetailAds extends StatelessWidget {
  const LoadingDetailAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Container(
            width: double.infinity,
            height: 30,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
          ),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                color: Colors.white,
              ),
              const SizedBox(width: AppDefaults.lSpace),
              Container(
                width: 40,
                height: 16,
                color: Colors.white,
              ),
              const Spacer(),
              Container(
                width: 80,
                height: 16,
                color: Colors.white,
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
          child: Container(
            width: double.infinity,
            height: 200,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(
            AppDefaults.padding,
          ),
          child: Container(
            width: double.infinity,
            height: 60,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
