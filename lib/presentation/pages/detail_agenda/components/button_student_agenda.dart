import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/presentation/widget/dialog_attendance_done.dart';

class ButtonStudentAgenda extends StatelessWidget {
  final Absensi? absensi;

  const ButtonStudentAgenda({
    Key? key,
    this.absensi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: ElevatedButton(
        onPressed: () {
          if (absensi?.statusAbsensi == '1') {
          } else {
            showDialog(
              context: context,
              builder: (context) => DialogAttendanceDone(absensi: absensi),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDefaults.mRadius),
          ),
          primary: absensi?.statusAbsensi == '1'
              ? AppColors.backgroundRed
              : AppColors.backgroundLightGrey,
        ),
        child: Text(
          absensi?.statusAbsensi == '1' ? "ABSENSI" : "SUDAH ABSEN",
          style: TextStyle(
            color: absensi?.statusAbsensi == '1' ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
