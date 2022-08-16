import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/widget/form/phone_form_field.dart';

class EditProfileForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  EditProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: AppDefaults.xxlSpace),
          PhoneFormField(
            controller: oldPasswordController,
            hintText: 'Max. 12 karakter',
            showLabel: true,
            labelText: 'No Handphone',
          ),
          const SizedBox(height: AppDefaults.xlSpace),
          PhoneFormField(
            controller: newPasswordController,
            hintText: 'Max. 12 karakter',
            showLabel: true,
            labelText: 'No Handphone Orangtua',
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
                }
              },
              child: const Text("Simpan"),
            ),
          ),
        ],
      ),
    );
  }
}
