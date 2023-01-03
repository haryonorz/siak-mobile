import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

class LoadingCheckBox extends StatelessWidget {
  const LoadingCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppDefaults.xlSpace,
      ),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            color: Colors.white,
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Container(
              height: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
