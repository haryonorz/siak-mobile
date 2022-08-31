import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:siak_mobile/common/app/app.dart';

class DialogLateReason extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final Function(String) onTap;

  DialogLateReason({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lateReasonController = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDefaults.sRadius)),
      child: Container(
        margin: const EdgeInsets.all(AppDefaults.margin),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Alasan Terlambat",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: MultiValidator(
                  [
                    RequiredValidator(errorText: 'Alasan required'),
                  ],
                ),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                controller: lateReasonController,
                decoration: InputDecoration(
                  hintText: "Tambahkan alasan terlambat..",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDefaults.lRadius),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDefaults.lRadius),
                    borderSide:
                        const BorderSide(color: AppColors.error, width: 1.2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      onTap(lateReasonController.text);
                      Navigator.pop(context, true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 38),
                    primary: AppColors.backgroundRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDefaults.mRadius),
                    ),
                  ),
                  child: const Text("Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
