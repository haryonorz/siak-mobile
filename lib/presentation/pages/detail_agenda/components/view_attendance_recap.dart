import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/domain/entities/absensi_rekap.dart';
import 'package:siak_mobile/presentation/widget/custom_field.dart';

class ViewAttendanceRecap extends StatelessWidget {
  final String idAgenda;
  final AbsensiRekap? absensiRekap;

  const ViewAttendanceRecap({
    Key? key,
    required this.idAgenda,
    required this.absensiRekap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalSiswaKelas = absensiRekap?.totalSiswaKelas ?? 0;
    int totalSiswaBelumAbsensi = absensiRekap?.totalSiswaBelumAbsensi ?? 0;
    int totalSiswaHadir = absensiRekap?.totalSiswaHadir ?? 0;
    int totalSiswaTamu = absensiRekap?.totalSiswaTamu ?? 0;
    int totalSiswaMenungguVerifikasi =
        absensiRekap?.totalSiswaMenungguVerifikasi ?? 0;
    int totalSiswaTidakHadir = absensiRekap?.totalSiswaTidakHadir ?? 0;

    return Container(
      padding: const EdgeInsets.all(20),
      color: AppColors.backgroundDarkBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rekapitulasi Kehadiran',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: AppDefaults.lSpace),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomField(
                        label: "Siswa Kelas",
                        value: "$totalSiswaKelas Orang",
                        direction: Axis.vertical,
                      ),
                      const SizedBox(height: 16),
                      CustomField(
                        label: "Belum Abesensi",
                        value: "$totalSiswaBelumAbsensi Orang",
                        direction: Axis.vertical,
                      ),
                      const SizedBox(height: 16),
                      CustomField(
                        label: "Hadir",
                        value: "$totalSiswaHadir Orang",
                        direction: Axis.vertical,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppDefaults.lSpace),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomField(
                        label: "Siswa Tamu",
                        value: "$totalSiswaTamu Orang",
                        direction: Axis.vertical,
                      ),
                      const SizedBox(height: 16),
                      CustomField(
                        label: "Menunggu Verifikasi",
                        value: "$totalSiswaMenungguVerifikasi Orang",
                        direction: Axis.vertical,
                      ),
                      const SizedBox(height: 16),
                      CustomField(
                        label: "Tidak Hadir",
                        value: "$totalSiswaTidakHadir Orang",
                        direction: Axis.vertical,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDefaults.lSpace),
          Center(
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.attendanceList,
                  arguments: idAgenda),
              child: Text(
                'Detail >',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: AppColors.textRed),
              ),
            ),
          )
        ],
      ),
    );
  }
}
