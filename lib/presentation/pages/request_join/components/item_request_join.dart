import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/presentation/cubit/action_agenda/action_agenda_cubit.dart';
import 'package:siak_mobile/presentation/widget/default_user_photo.dart';
import 'package:siak_mobile/presentation/widget/user_photo.dart';

class ItemRequestJoin extends StatelessWidget {
  final Absensi absensi;

  const ItemRequestJoin({Key? key, required this.absensi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      child: Row(
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
                Text(
                  absensi.pilKelas,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(color: AppColors.textGrey),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDefaults.lSpace),
          ElevatedButton(
            onPressed: () {
              context
                  .read<ActionAgendaCubit>()
                  .acceptRequestJoin(absensi.idAgenda, absensi.noSiswa);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(90, 38),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDefaults.mRadius),
              ),
            ),
            child: const Text("Terima"),
          ),
        ],
      ),
    );
  }
}
