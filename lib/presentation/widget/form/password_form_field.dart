import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:siak_mobile/common/app/app.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool showLabel;
  final String? labelText;
  final bool roundedField;

  const PasswordFormField({
    required this.controller,
    this.hintText = 'Password',
    this.showLabel = false,
    this.labelText,
    this.roundedField = true,
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool obsecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.showLabel
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(widget.labelText ?? 'label'),
              )
            : Container(),
        TextFormField(
          validator: MultiValidator(
            [
              RequiredValidator(errorText: 'Password required'),
              MinLengthValidator(6,
                  errorText: 'Password must be at least 6 digits'),
            ],
          ),
          obscureText: obsecurePassword,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: AppDefaults.padding),
              child: GestureDetector(
                onTap: () => setState(() {
                  obsecurePassword = !obsecurePassword;
                }),
                child: Icon(
                  obsecurePassword ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.iconWhite,
                ),
              ),
            ),
            border: widget.roundedField
                ? null
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDefaults.sRadius),
                    borderSide: BorderSide.none,
                  ),
            errorBorder: widget.roundedField
                ? null
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDefaults.sRadius),
                    borderSide:
                        const BorderSide(color: AppColors.error, width: 1.2),
                  ),
          ),
        ),
      ],
    );
  }
}
