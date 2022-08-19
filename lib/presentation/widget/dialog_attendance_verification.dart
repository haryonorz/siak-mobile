import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/presentation/cubit/action_agenda/action_agenda_cubit.dart';

class DialogAttendanceVerification extends StatelessWidget {
  final Absensi absensi;

  const DialogAttendanceVerification({
    Key? key,
    required this.absensi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 4),
            Text(
              "Murid ${absensi.namaSiswa} sudah melakukan absensi.\nApakah murid ${absensi.namaSiswa} menghadiri kelas?",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: AppDefaults.xlSpace),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(80, 38),
                  primary: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: AppColors.backgroundRed,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(AppDefaults.mRadius),
                  ),
                ),
                child: const Text(
                  "Foto Ulang",
                  style: TextStyle(color: AppColors.textRed),
                ),
              ),
            ),
            const SizedBox(height: AppDefaults.lSpace),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ActionAgendaCubit>().verificationAttends(
                            absensi.idAgenda,
                            absensi.noSiswa,
                            '3',
                          );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80, 38),
                      primary: AppColors.backgroundRed,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDefaults.mRadius),
                      ),
                    ),
                    child: const Text("Tidak Hadir"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ActionAgendaCubit>().verificationAttends(
                            absensi.idAgenda,
                            absensi.noSiswa,
                            '2',
                          );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80, 38),
                      primary: AppColors.backgroundRed,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDefaults.mRadius),
                      ),
                    ),
                    child: const Text("Hadir"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
