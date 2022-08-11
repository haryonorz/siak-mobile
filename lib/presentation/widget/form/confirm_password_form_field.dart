import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:siak_mobile/common/app/app.dart';

class ConfirmPasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController passcontroller;
  final String hintText;
  final bool showLabel;
  final String? labelText;
  final bool roundedField;

  const ConfirmPasswordFormField({
    required this.controller,
    required this.passcontroller,
    this.hintText = 'Password',
    this.showLabel = false,
    this.labelText,
    this.roundedField = true,
    Key? key,
  }) : super(key: key);

  @override
  State<ConfirmPasswordFormField> createState() =>
      _ConfirmPasswordFormFieldState();
}

class _ConfirmPasswordFormFieldState extends State<ConfirmPasswordFormField> {
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password required';
            }
            return MatchValidator(errorText: 'Password tidak sama')
                .validateMatch(value, widget.passcontroller.text);
          },
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
