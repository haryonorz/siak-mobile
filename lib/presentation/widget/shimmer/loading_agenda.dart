import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

class LoadingAgenda extends StatelessWidget {
  const LoadingAgenda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppDefaults.margin,
        right: AppDefaults.margin,
        bottom: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDefaults.lRadius),
            child: Container(
              width: 160,
              height: 220,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: AppDefaults.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(height: AppDefaults.lSpace),
                  Container(
                    width: 80,
                    height: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(height: AppDefaults.sSpace),
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: AppDefaults.lSpace),
                  Container(
                    width: 40,
                    height: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(height: AppDefaults.sSpace),
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
