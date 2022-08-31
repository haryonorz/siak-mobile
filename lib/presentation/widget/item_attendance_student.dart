import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/extensions/string_parsing.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/presentation/widget/custom_field.dart';
import 'package:siak_mobile/presentation/widget/default_user_photo.dart';
import 'package:siak_mobile/presentation/widget/dialog_attendance.dart';
import 'package:siak_mobile/presentation/widget/dialog_attendance_verification.dart';
import 'package:siak_mobile/presentation/widget/user_photo.dart';

class ItemAttendanceStudent extends StatelessWidget {
  final Agenda agenda;
  final Absensi absensi;
  final bool showPhotoAbsensi;
  final String userType;

  const ItemAttendanceStudent({
    Key? key,
    required this.agenda,
    required this.absensi,
    this.showPhotoAbsensi = true,
    required this.userType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String statusAbsensi;
    late Color statusColor;

    String dateAttend = absensi.tgl ?? ' -';
    String timeAttend = absensi.jam ?? ' -';

    String photoUrl =
        '${EndPoints.baseUrlPhoto}/absen/${absensi.fotoAbsenTutor ?? absensi.fotoAbsen}';

    switch (absensi.statusAbsensi) {
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
        if (absensi.terlambat == 'X') {
          statusAbsensi = '$statusAbsensi, Terlambat';
          if (absensi.alasanTerlambat != null &&
              absensi.alasanTerlambat != '') {
            statusAbsensi = '$statusAbsensi (${absensi.alasanTerlambat})';
          }
        }
        statusColor = AppColors.textGreen;
        break;
      default:
        statusAbsensi = 'Tidak Hadir';
        statusColor = AppColors.textRed;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          absensi.foto != null && absensi.foto != ''
              ? UserPhoto(
                  width: 42,
                  height: 42,
                  url: '${EndPoints.baseUrlPhoto}/profile/${absensi.foto}',
                  photoPreview: userType == 'tutor',
                )
              : DefaultUserPhoto(
                  width: 42,
                  height: 42,
                  photoPreview: userType == 'tutor',
                ),
          const SizedBox(width: AppDefaults.lSpace),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  absensi.namaSiswa,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  absensi.pilKelas,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(color: AppColors.textGrey),
                ),
                const SizedBox(height: AppDefaults.sSpace),
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
              ],
            ),
          ),
          const SizedBox(width: AppDefaults.lSpace),
          showPhotoAbsensi
              ? (absensi.fotoAbsen != null)
                  ? GestureDetector(
                      onTap: () {
                        if (userType == 'tutor') {
                          if (absensi.statusAbsensi == '0') {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  DialogAttendanceVerification(
                                agenda: agenda,
                                absensi: absensi,
                              ),
                            );
                          } else {
                            Navigator.pushNamed(
                              context,
                              Routes.photoPreview,
                              arguments: photoUrl,
                            );
                          }
                        } else {
                          Navigator.pushNamed(
                            context,
                            Routes.photoPreview,
                            arguments: photoUrl,
                          );
                        }
                      },
                      child: OctoImage(
                        width: 70,
                        height: 90,
                        image: CachedNetworkImageProvider(photoUrl),
                        placeholderBuilder:
                            OctoPlaceholder.circularProgressIndicator(),
                        errorBuilder:
                            OctoError.icon(color: AppColors.backgroundRed),
                        fit: BoxFit.cover,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        if (absensi.statusAbsensi == '1') {
                          showDialog(
                            context: context,
                            builder: (context) => DialogAttendance(
                              agenda: agenda,
                              absensi: absensi,
                              userType: userType,
                            ),
                          );
                        }
                        if (userType == 'tutor') {
                          if (absensi.statusAbsensi == '0') {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  DialogAttendanceVerification(
                                agenda: agenda,
                                absensi: absensi,
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        width: 70,
                        height: 90,
                        color: AppColors.backgroundGrey,
                        child: Stack(
                          children: [
                            const Center(
                              child: Icon(
                                Icons.hide_image_outlined,
                                size: 36,
                                color: AppColors.backgroundLightGrey,
                              ),
                            ),
                            Center(
                              child: Text(
                                'NO IMAGE',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
              : Container(),
        ],
      ),
    );
  }
}
