import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/presentation/cubit/action_agenda/action_agenda_cubit.dart';
import 'package:siak_mobile/presentation/cubit/all_student/all_student_cubit.dart';
import 'package:siak_mobile/presentation/widget/item_attendance_student.dart';
import 'package:siak_mobile/presentation/widget/view_empty.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class ViewAttendanceStudent extends StatefulWidget {
  final String idAgenda;
  final Absensi? absensiUser;

  const ViewAttendanceStudent({
    Key? key,
    required this.idAgenda,
    this.absensiUser,
  }) : super(key: key);

  @override
  State<ViewAttendanceStudent> createState() => _ViewAttendanceStudentState();
}

class _ViewAttendanceStudentState extends State<ViewAttendanceStudent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<AllStudentCubit>().fetchData(widget.idAgenda));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActionAgendaCubit, ActionAgendaState>(
      listener: (context, state) {
        if (state is ActionAgendaSuccess) {
          context.read<AllStudentCubit>().fetchData(widget.idAgenda);
        }
        if (state is ActionAgendaError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.textWhite),
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDefaults.sRadius)),
              elevation: 0,
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: BlocBuilder<AllStudentCubit, AllStudentState>(
        builder: (context, state) {
          if (state is AllStudentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllStudentEmpty) {
            return ViewEmpty(
              title: 'Tidak ada siswa!',
              description:
                  'Silahkan periksa data siswa pada kelas yang bersangkutan.',
              showRefresh: true,
              onRefresh: () {
                context.read<AllStudentCubit>().fetchData(widget.idAgenda);
              },
            );
          } else if (state is AllStudentHasData) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<AllStudentCubit>().fetchData(widget.idAgenda);
              },
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final absensi = state.absensi[index];
                  return Container(
                    margin: EdgeInsets.only(
                      top: index == 0 ? 16 : 0,
                      bottom: 16,
                    ),
                    child: ItemAttendanceStudent(
                      absensi: absensi,
                      showPhotoAbsensi: state.user.type == 'tutor'
                          ? true
                          : absensi.noSiswa == widget.absensiUser?.noSiswa,
                      userType: state.user.type,
                    ),
                  );
                },
                itemCount: state.absensi.length,
              ),
            );
          } else if (state is AllStudentError) {
            return ViewError(
              message: state.message,
              showRefresh: true,
              onRefresh: () {
                context.read<AllStudentCubit>().fetchData(widget.idAgenda);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
