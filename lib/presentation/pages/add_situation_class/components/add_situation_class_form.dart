import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:siak_mobile/common/app/app.dart';

class AddSituationClassForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  AddSituationClassForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentController = TextEditingController();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text('Siswa'),
            ),
            TextFormField(
              onTap: () {},
              validator: MultiValidator(
                [
                  RequiredValidator(errorText: 'Siswa required'),
                ],
              ),
              keyboardType: TextInputType.text,
              controller: studentController,
              enabled: false,
              decoration: InputDecoration(
                hintText: "Pilih siswa",
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: AppDefaults.padding),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.iconWhite,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDefaults.sRadius),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDefaults.sRadius),
                  borderSide:
                      const BorderSide(color: AppColors.error, width: 1.2),
                ),
              ),
            ),
            const SizedBox(height: AppDefaults.xlSpace),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text('Permasalahan Siswa'),
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
                child: const Text("Tambahkan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
