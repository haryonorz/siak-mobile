import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/presentation/cubit/all_guest_student/all_guest_student_cubit.dart';
import 'package:siak_mobile/presentation/widget/item_attendance_student.dart';
import 'package:siak_mobile/presentation/widget/view_empty.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class ViewAttendanceGuestStudent extends StatefulWidget {
  final String idAgenda;
  final Absensi? absensiUser;

  const ViewAttendanceGuestStudent({
    Key? key,
    required this.idAgenda,
    this.absensiUser,
  }) : super(key: key);

  @override
  State<ViewAttendanceGuestStudent> createState() =>
      _ViewAttendanceGuestStudentState();
}

class _ViewAttendanceGuestStudentState
    extends State<ViewAttendanceGuestStudent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<AllGuestStudentCubit>().fetchData(widget.idAgenda));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllGuestStudentCubit, AllGuestStudentState>(
      builder: (context, state) {
        if (state is AllGuestStudentLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AllGuestStudentEmpty) {
          return ViewEmpty(
            title: 'Tidak ada siswa tamu!',
            description:
                'Silahkan periksa permintaan ikut kelas untuk mengetahui siswa tamu yang ingin mengikuti kelas.',
            showRefresh: true,
            onRefresh: () {
              context.read<AllGuestStudentCubit>().fetchData(widget.idAgenda);
            },
          );
        } else if (state is AllGuestStudentHasData) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<AllGuestStudentCubit>().fetchData(widget.idAgenda);
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
                  ),
                );
              },
              itemCount: state.absensi.length,
            ),
          );
        } else if (state is AllGuestStudentError) {
          return ViewError(
            message: state.message,
            showRefresh: true,
            onRefresh: () {
              context.read<AllGuestStudentCubit>().fetchData(widget.idAgenda);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
