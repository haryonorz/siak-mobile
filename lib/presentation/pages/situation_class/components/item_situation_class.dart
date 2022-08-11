import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/presentation/widget/custom_field.dart';
import 'package:siak_mobile/presentation/widget/default_user_photo.dart';
import 'package:siak_mobile/presentation/widget/user_photo.dart';

class ItemSituationClass extends StatelessWidget {
  final Absensi absensi;

  const ItemSituationClass({Key? key, required this.absensi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: AppDefaults.sSpace),
                CustomField(
                  label: "Masalah: ",
                  value: absensi.masalahSiswa ?? '-',
                  valueStyle: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
