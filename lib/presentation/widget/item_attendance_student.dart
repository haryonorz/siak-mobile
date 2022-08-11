import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/extensions/string_parsing.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/presentation/widget/custom_field.dart';
import 'package:siak_mobile/presentation/widget/default_user_photo.dart';
import 'package:siak_mobile/presentation/widget/user_photo.dart';

class ItemAttendanceStudent extends StatelessWidget {
  final Absensi absensi;

  const ItemAttendanceStudent({Key? key, required this.absensi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String statusAbsensi;
    late Color statusColor;

    String dateAttend = absensi.tgl ?? ' -';
    String timeAttend = absensi.jam ?? ' -';

    String photoUrl = '${EndPoints.baseUrlPhoto}/absen/${absensi.fotoAbsen}';

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
        if (absensi.terlambat == 'X') statusAbsensi = 'Terlambat';
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
          absensi.foto.isNotEmpty
              ? UserPhoto(
                  width: 42,
                  height: 42,
                  url: '${EndPoints.baseUrlPhoto}/profile/${absensi.foto}',
                )
              : const DefaultUserPhoto(width: 42, height: 42),
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
          if (absensi.fotoAbsen != null)
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                Routes.photoPreview,
                arguments: photoUrl,
              ),
              child: OctoImage(
                width: 70,
                height: 90,
                image: CachedNetworkImageProvider(photoUrl),
                placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
                errorBuilder: OctoError.icon(color: AppColors.backgroundRed),
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
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
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
