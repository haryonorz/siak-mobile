import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/cubit/action_agenda/action_agenda_cubit.dart';

class DialogNoteClass extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final String idAgenda;

  DialogNoteClass({Key? key, required this.idAgenda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteController = TextEditingController();

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
                "Catatan Kelas",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: MultiValidator(
                  [
                    RequiredValidator(errorText: 'Note required'),
                  ],
                ),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                controller: noteController,
                decoration: InputDecoration(
                  hintText: "Tambahkan catatan kelas..",
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
                      context
                          .read<ActionAgendaCubit>()
                          .updateNoteClass(idAgenda, noteController.text);
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
