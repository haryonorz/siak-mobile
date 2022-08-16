import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/arg_selected_student.dart';
import 'package:siak_mobile/domain/entities/problem_class.dart';
import 'package:siak_mobile/presentation/cubit/action_situation_class/action_situation_class_cubit.dart';
import 'package:siak_mobile/presentation/cubit/info_problem_class/info_problem_class_cubit.dart';

class AddSituationClassForm extends StatelessWidget {
  final String idAgenda;

  AddSituationClassForm({
    Key? key,
    required this.idAgenda,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final studentController = TextEditingController();
    final otherController = TextEditingController();

    String? selectedStudent;
    late List<ProblemClass> selectedProblem;

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
              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  Routes.listSelectedStudent,
                  arguments: ArgSelectedStudent(
                    idAgenda: idAgenda,
                    nosiswa: selectedStudent,
                  ),
                ) as Absensi;
                selectedStudent = result.noSiswa;
                studentController.text = result.namaSiswa;
              },
              validator: MultiValidator(
                [
                  RequiredValidator(errorText: 'Siswa required'),
                ],
              ),
              keyboardType: TextInputType.text,
              controller: studentController,
              readOnly: true,
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
            const SizedBox(height: AppDefaults.lSpace),
            BlocBuilder<InfoProblemClassCubit, InfoProblemClassState>(
              builder: (context, state) {
                if (state is InfoProblemClassLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is InfoProblemClassHasData) {
                  selectedProblem = state.problemList
                      .where((element) => element.selected)
                      .toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: state.problemList
                            .map(
                              (e) => CheckboxListTile(
                                title: Text(e.description),
                                value: e.selected,
                                dense: true,
                                activeColor: AppColors.backgroundRed,
                                onChanged: (value) {
                                  context
                                      .read<InfoProblemClassCubit>()
                                      .selectedItem(
                                          e.copywith(selected: value));
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
                                controller: otherController,
                                decoration: InputDecoration(
                                  hintText: "Keterangan permasalahan lainnya..",
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
                    context.read<ActionSituationClassCubit>().addSituationClass(
                          idAgenda,
                          selectedStudent ?? '',
                          otherController.text,
                          selectedProblem,
                        );
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
