import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

class LoadingAttendanceStudent extends StatelessWidget {
  const LoadingAttendanceStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 40,
              height: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: AppDefaults.lSpace),
          Expanded(
            child: Column(
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
                const SizedBox(height: AppDefaults.lSpace),
                Container(
                  width: 110,
                  height: 14,
                  color: Colors.white,
                ),
                const SizedBox(height: AppDefaults.sSpace),
                Container(
                  width: 110,
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
          const SizedBox(width: AppDefaults.lSpace),
          Container(
            width: 70,
            height: 90,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
