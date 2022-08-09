import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/presentation/cubit/all_student/all_student_cubit.dart';
import 'package:siak_mobile/presentation/widget/item_attendance_student.dart';

class ViewAttendanceStudent extends StatefulWidget {
  final String idAgenda;

  const ViewAttendanceStudent({Key? key, required this.idAgenda})
      : super(key: key);

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
    return BlocBuilder<AllStudentCubit, AllStudentState>(
      builder: (context, state) {
        if (state is AllStudentLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AllStudentEmpty) {
          return const Center(
            child: Text('No Data'),
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
                  child: ItemAttendanceStudent(absensi: absensi),
                );
              },
              itemCount: state.absensi.length,
            ),
          );
        } else if (state is AllStudentError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
