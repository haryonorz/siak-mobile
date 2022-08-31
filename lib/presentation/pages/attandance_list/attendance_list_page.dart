import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/presentation/pages/attandance_list/components/view_attendance_guest_student.dart';
import 'package:siak_mobile/presentation/pages/attandance_list/components/view_attendance_student.dart';

class AttendanceListPage extends StatelessWidget {
  final Agenda agenda;
  final Absensi? absensi;

  const AttendanceListPage({
    Key? key,
    required this.agenda,
    this.absensi,
  }) : super(key: key);

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
            ViewAttendanceStudent(
              agenda: agenda,
              absensiUser: absensi,
            ),
            ViewAttendanceGuestStudent(
              agenda: agenda,
              absensiUser: absensi,
            ),
          ],
        ),
      ),
    );
  }
}
