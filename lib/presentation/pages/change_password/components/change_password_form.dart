import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/cubit/change_password/change_password_cubit.dart';
import 'package:siak_mobile/presentation/widget/form/confirm_password_form_field.dart';
import 'package:siak_mobile/presentation/widget/form/password_form_field.dart';

class ChangePasswordForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ChangePasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmNewPasswordController = TextEditingController();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PasswordFormField(
              controller: oldPasswordController,
              hintText: 'Min. 6 karakter',
              showLabel: true,
              labelText: 'Kata Sandi Lama',
              roundedField: false,
            ),
            const SizedBox(height: AppDefaults.xlSpace),
            PasswordFormField(
              controller: newPasswordController,
              hintText: 'Min. 6 karakter',
              showLabel: true,
              labelText: 'Kata Sandi Baru',
              roundedField: false,
            ),
            const SizedBox(height: AppDefaults.xlSpace),
            ConfirmPasswordFormField(
              controller: confirmNewPasswordController,
              passcontroller: newPasswordController,
              hintText: 'Min. 6 karakter',
              showLabel: true,
              labelText: 'Ulangi Sandi Sandi Baru',
              roundedField: false,
            ),
            const SizedBox(height: AppDefaults.xxlSpace),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(110, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDefaults.mRadius),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context.read<ChangePasswordCubit>().doChangePassword(
                          oldPasswordController.text,
                          newPasswordController.text,
                        );
                  }
                },
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
