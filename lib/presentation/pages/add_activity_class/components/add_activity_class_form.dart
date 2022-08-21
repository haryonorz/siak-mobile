import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/domain/entities/activity_class.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/presentation/cubit/action_activity_class/action_activity_class_cubit.dart';
import 'package:siak_mobile/presentation/cubit/info_activity_class/info_activity_class_cubit.dart';

class AddActivityClassForm extends StatelessWidget {
  final Agenda agenda;

  AddActivityClassForm({
    Key? key,
    required this.agenda,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final otherController = TextEditingController();
    otherController.text = agenda.aktivitasLainnya ?? '';

    late List<ActivityClass> selectedActivity;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<InfoActivityClassCubit, InfoActivityClassState>(
              builder: (context, state) {
                if (state is InfoActivityClassLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is InfoActivityClassHasData) {
                  selectedActivity = state.activityList
                      .where((element) => element.selected)
                      .toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: state.activityList
                            .map(
                              (e) => CheckboxListTile(
                                title: Text(e.description),
                                value: e.selected,
                                dense: true,
                                activeColor: AppColors.backgroundRed,
                                onChanged: (value) {
                                  if (agenda.status == '0') {
                                    context
                                        .read<InfoActivityClassCubit>()
                                        .selectedItem(
                                            e.copywith(selected: value));
                                  }
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            )
                            .toList(),
                      ),
                      state.otherSelected
                          ? Container(
                              margin: const EdgeInsets.only(top: 8, left: 20),
                              child: TextFormField(
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                        errorText: 'Keterangan required'),
                                  ],
                                ),
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.done,
                                readOnly: agenda.status == '1',
                                controller: otherController,
                                decoration: InputDecoration(
                                  hintText: "Keterangan akitvitas lainnya..",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppDefaults.lRadius),
                                    borderSide: BorderSide.none,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppDefaults.lRadius),
                                    borderSide: const BorderSide(
                                        color: AppColors.error, width: 1.2),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(height: AppDefaults.xxlSpace),
            agenda.status == '0'
                ? Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(110, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDefaults.mRadius),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          context
                              .read<ActionActivityClassCubit>()
                              .addDailyActivity(
                                agenda.idAgenda,
                                selectedActivity,
                                otherController.text,
                              );
                        }
                      },
                      child: const Text("Simpan"),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
