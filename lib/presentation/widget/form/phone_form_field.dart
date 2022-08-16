import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:siak_mobile/common/app/app.dart';

class PhoneFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool showLabel;
  final String? labelText;

  const PhoneFormField({
    Key? key,
    required this.controller,
    this.hintText = 'No Handphone',
    this.showLabel = false,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showLabel
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(labelText ?? 'label'),
              )
            : Container(),
        TextFormField(
          validator: MultiValidator(
            [
              RequiredValidator(errorText: 'Password required'),
              MaxLengthValidator(12,
                  errorText: 'No handphone cannot more than 12 digits'),
            ],
          ),
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDefaults.sRadius),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDefaults.sRadius),
              borderSide: const BorderSide(color: AppColors.error, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}
