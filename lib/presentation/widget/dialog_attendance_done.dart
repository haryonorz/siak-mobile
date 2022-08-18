import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/extensions/string_parsing.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/presentation/widget/custom_field.dart';

class DialogAttendanceDone extends StatelessWidget {
  final Absensi? absensi;

  const DialogAttendanceDone({
    Key? key,
    required this.absensi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String statusAbsensi;
    late Color statusColor;

    String dateAttend = absensi?.tgl ?? ' -';
    String timeAttend = absensi?.jam ?? ' -';

    // String photoUrl = '${EndPoints.baseUrlPhoto}/absen/${absensi.fotoAbsen}';

    switch (absensi?.statusAbsensi) {
      case '0':
        statusAbsensi = 'Menunggu Verifikasi Tutor';
        statusColor = AppColors.textYellow;
        break;
      case '1':
        statusAbsensi = 'Belum Absensi';
        statusColor = AppColors.textWhite;
        break;
      case '2':
        statusAbsensi = 'Hadir';
        if (absensi?.terlambat == 'X') {
          statusAbsensi = '$statusAbsensi, Terlambat';
          if (absensi?.alasanTerlambat != null) {
            statusAbsensi = '$statusAbsensi (${absensi?.alasanTerlambat})';
          }
        }
        statusColor = AppColors.textGreen;
        break;
      default:
        statusAbsensi = 'Tidak Hadir';
        statusColor = AppColors.textRed;
    }

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDefaults.sRadius)),
      child: Container(
        margin: const EdgeInsets.all(AppDefaults.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Absensi",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text("Sudah Melakukan Absensi",
                style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(height: 4),
            CustomField(
              label: "Tanggal: ",
              value: dateAttend != ' -'
                  ? dateAttend.parseDate(
                      fromFormat: "yyyy-MM-dd",
                      toFormat: "EEEE, dd MMM yyyy",
                    )
                  : dateAttend,
              valueStyle: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(height: 2),
            CustomField(
              label: "Pukul: ",
              value: timeAttend != ' -'
                  ? timeAttend.parseDate(
                      fromFormat: "HH:mm:ss",
                      toFormat: "HH:mm",
                    )
                  : timeAttend,
              valueStyle: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(height: 2),
            CustomField(
              label: "Status: ",
              value: statusAbsensi,
              valueStyle: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(color: statusColor),
            ),
            const SizedBox(height: AppDefaults.xlSpace),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(80, 38),
                  primary: AppColors.backgroundRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDefaults.mRadius),
                  ),
                ),
                child: const Text("Ok"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
