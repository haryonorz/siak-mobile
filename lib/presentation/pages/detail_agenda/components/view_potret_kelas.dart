import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app_colors.dart';
import 'package:siak_mobile/common/app/app_defaults.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';

class ViewPotretKelas extends StatelessWidget {
  final Agenda agenda;

  const ViewPotretKelas({Key? key, required this.agenda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDefaults.margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Potret Kelas',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: AppColors.textRed),
          ),
          const SizedBox(height: AppDefaults.lSpace),
          Text(
            'Buat laporan kondisi kelas kamu untuk anak-anak yang tidak kondusif dalam kelas',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(
              context,
              Routes.situationClass,
              arguments: agenda,
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(120, 45),
              backgroundColor: AppColors.backgroundBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDefaults.mRadius),
              ),
              side: const BorderSide(
                width: 1.2,
                color: AppColors.borderRed,
              ),
            ),
            child: Text(
              agenda.status == '0' ? 'Buat Laporan' : 'Lihat Laporan',
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: AppColors.textRed),
            ),
          ),
        ],
      ),
    );
  }
}
