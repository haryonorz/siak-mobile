import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/presentation/cubit/accept_request_join/accept_request_join_cubit.dart';
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
          UserPhoto(
            width: 42,
            height: 42,
            url: absensi.foto != null &&
                    absensi.foto != '' &&
                    absensi.foto != 'http://siak.bimbel-strategis.com/uploads/'
                ? absensi.foto.toString()
                : '',
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
                  .read<AcceptRequestJoinCubit>()
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
