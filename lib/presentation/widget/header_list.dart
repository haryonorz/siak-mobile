import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

class HeaderList extends StatelessWidget {
  final String title;
  final bool isShowMore;
  final VoidCallback onMoreTap;

  const HeaderList({
    super.key,
    required this.title,
    this.isShowMore = false,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              isShowMore
                  ? GestureDetector(
                      onTap: onMoreTap,
                      child: const Text('More'),
                    )
                  : Container(),
            ],
          ),
        ),
        const SizedBox(
          height: AppDefaults.lSpace,
        ),
      ],
    );
  }
}
