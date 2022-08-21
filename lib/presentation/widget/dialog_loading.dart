import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

class DialogLoading extends StatelessWidget {
  final String title;

  const DialogLoading({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDefaults.sRadius)),
      child: Container(
        margin: const EdgeInsets.all(AppDefaults.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: AppDefaults.sSpace),
            Text(
              "Please wait for a moment",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
