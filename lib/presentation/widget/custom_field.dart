import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

class CustomField extends StatelessWidget {
  final String label;
  final String value;

  const CustomField({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: AppColors.textGrey),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
