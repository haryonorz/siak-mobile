import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/pages/attandance_list/components/view_attendance_guest_student.dart';
import 'package:siak_mobile/presentation/pages/attandance_list/components/view_attendance_student.dart';

class AttendanceListPage extends StatelessWidget {
  final String idAgenda;

  const AttendanceListPage({Key? key, required this.idAgenda})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Kehadiran Siswa'),
          systemOverlayStyle: AppDefaults.statusBarDarkBlue,
          bottom: const TabBar(
            indicatorColor: AppColors.backgroundRed,
            labelColor: AppColors.textRed,
            unselectedLabelColor: AppColors.textWhite,
            tabs: [
              Tab(text: 'Siswa'),
              Tab(text: 'Siswa Tamu'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ViewAttendanceStudent(idAgenda: idAgenda),
            ViewAttendanceGuestStudent(idAgenda: idAgenda),
          ],
        ),
      ),
    );
  }
}
