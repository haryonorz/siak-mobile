import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:siak_mobile/common/app/app.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordFormField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool obsecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        hintText: "Password",
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
      ),
    );
  }
}
