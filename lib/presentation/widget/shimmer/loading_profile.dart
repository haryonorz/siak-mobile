import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

class LoadingProfile extends StatelessWidget {
  const LoadingProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 140,
                height: 16,
                color: Colors.white,
              ),
              const SizedBox(height: AppDefaults.lSpace),
              Container(
                width: 100,
                height: 14,
                color: Colors.white,
              ),
              const SizedBox(height: AppDefaults.sSpace),
              Container(
                width: 100,
                height: 14,
                color: Colors.white,
              ),
              const SizedBox(height: AppDefaults.sSpace),
              Container(
                width: 110,
                height: 14,
                color: Colors.white,
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            width: 80,
            height: 80,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
