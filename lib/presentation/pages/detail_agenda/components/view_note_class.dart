import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app_colors.dart';
import 'package:siak_mobile/common/app/app_defaults.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/presentation/widget/dialog_note_class.dart';

class ViewNoteClass extends StatelessWidget {
  final Agenda agenda;

  const ViewNoteClass({Key? key, required this.agenda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AppColors.backgroundDarkBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Catatan Kelas',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: AppColors.textRed),
          ),
          const SizedBox(height: AppDefaults.lSpace),
          Text(
            agenda.catatanKelas ?? "-",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      DialogNoteClass(idAgenda: agenda.idAgenda),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 45),
                primary: AppColors.backgroundRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDefaults.mRadius),
                ),
              ),
              child: Text(
                "+ Tambahkan Catatan",
                style: Theme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
