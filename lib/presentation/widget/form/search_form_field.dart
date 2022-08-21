import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/widget/decorated_input_border.dart';

class SearchFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const SearchFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
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
