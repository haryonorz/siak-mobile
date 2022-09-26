import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

class ViewEmpty extends StatelessWidget {
  final String title;
  final String description;
  final bool showRefresh;
  final VoidCallback? onRefresh;

  const ViewEmpty({
    Key? key,
    required this.title,
    required this.description,
    this.showRefresh = false,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppDefaults.sSpace),
          Text(description),
          const SizedBox(height: AppDefaults.xlSpace),
          showRefresh
              ? ElevatedButton(
                  onPressed: onRefresh,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 36),
                    backgroundColor: AppColors.backgroundRed,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDefaults.mRadius),
                    ),
                  ),
                  child: const Text("Refresh"),
                )
              : Container(),
        ],
      ),
    );
  }
}
