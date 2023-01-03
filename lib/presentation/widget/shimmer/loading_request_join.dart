import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

class LoadingRequestJoin extends StatelessWidget {
  const LoadingRequestJoin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 42,
              height: 42,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 140,
                height: 16,
                color: Colors.white,
              ),
              const SizedBox(height: AppDefaults.sSpace),
              Container(
                width: 40,
                height: 14,
                color: Colors.white,
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 90,
            height: 38,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
