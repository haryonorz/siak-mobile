import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/utils.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/presentation/cubit/all_student/all_student_cubit.dart';
import 'package:siak_mobile/presentation/cubit/verification_attendance_cubit/action_attendance_cubit.dart';
import 'package:siak_mobile/presentation/widget/item_attendance_student.dart';
import 'package:siak_mobile/presentation/widget/view_empty.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class ViewAttendanceStudent extends StatefulWidget {
  final Agenda agenda;
  final Absensi? absensiUser;

  const ViewAttendanceStudent({
    Key? key,
    required this.agenda,
    this.absensiUser,
  }) : super(key: key);

  @override
  State<ViewAttendanceStudent> createState() => _ViewAttendanceStudentState();
}

class _ViewAttendanceStudentState extends State<ViewAttendanceStudent>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<AllStudentCubit>().fetchData(widget.agenda.idAgenda));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<AllStudentCubit>().fetchData(widget.agenda.idAgenda);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationAttendanceCubit,
        VerificationAttendanceState>(
      listener: (context, state) {
        if (state is VerificationAttendanceSuccess) {
          context.read<AllStudentCubit>().fetchData(widget.agenda.idAgenda);
        }
        if (state is VerificationAttendanceError) {
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
                context
                    .read<AllStudentCubit>()
                    .fetchData(widget.agenda.idAgenda);
              },
            );
          } else if (state is AllStudentHasData) {
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<AllStudentCubit>()
                    .fetchData(widget.agenda.idAgenda);
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
                      agenda: widget.agenda,
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
                context
                    .read<AllStudentCubit>()
                    .fetchData(widget.agenda.idAgenda);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
