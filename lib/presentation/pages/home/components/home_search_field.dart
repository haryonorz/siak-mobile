import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/widget/decorated_input_border.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: "Agenda Hari Ini",
        prefixIcon: const Icon(Icons.search),
        border: DecoratedInputBorder(
          shadow: AppDefaults.boxShadowInput,
          child: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDefaults.sRadius),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
