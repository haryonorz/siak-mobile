import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/presentation/widget/form/phone_form_field.dart';

class EditProfileForm extends StatefulWidget {
  final User user;

  const EditProfileForm({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final parentPhoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneNumberController.text = widget.user.noHp;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: AppDefaults.xxlSpace),
          PhoneFormField(
            controller: phoneNumberController,
            hintText: 'Max. 12 karakter',
            showLabel: true,
            labelText: 'No Handphone',
          ),
          const SizedBox(height: AppDefaults.xlSpace),
          widget.user.type == 'tutor'
              ? Container()
              : PhoneFormField(
                  controller: parentPhoneNumberController,
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
