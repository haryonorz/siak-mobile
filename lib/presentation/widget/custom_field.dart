import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

class CustomField extends StatelessWidget {
  final String label;
  final String value;
  final Axis direction;
  final TextStyle? valueStyle;

  const CustomField({
    Key? key,
    required this.label,
    required this.value,
    this.direction = Axis.horizontal,
    this.valueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: direction == Axis.horizontal
          ? WrapCrossAlignment.center
          : WrapCrossAlignment.start,
      direction: direction,
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
          style: valueStyle ??
              Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
