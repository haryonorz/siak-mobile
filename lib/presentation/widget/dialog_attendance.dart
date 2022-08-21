import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/arg_camera_attandance.dart';

class DialogAttendance extends StatelessWidget {
  final Absensi absensi;
  final String userType;

  const DialogAttendance({
    Key? key,
    required this.absensi,
    required this.userType,
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
            Text("Anda ingin melakukan absensi?",
                style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(height: AppDefaults.xlSpace),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
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
                        borderRadius:
                            BorderRadius.circular(AppDefaults.mRadius),
                      ),
                    ),
                    child: const Text(
                      "Tidak",
                      style: TextStyle(color: AppColors.textRed),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        Routes.cameraAttendance,
                        arguments: ArgCameraAttendance(
                          absensi: absensi,
                          userType: userType,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80, 38),
                      primary: AppColors.backgroundRed,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDefaults.mRadius),
                      ),
                    ),
                    child: const Text("Ya"),
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
