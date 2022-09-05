import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

class DialogPermission extends StatelessWidget {
  final Function onTap;

  const DialogPermission({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDefaults.sRadius)),
      child: Container(
        margin: const EdgeInsets.all(AppDefaults.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Perbarui pengaturan lokasi',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: AppDefaults.xxlSpace),
            Center(
              child: Image.asset(
                'assets/images/icon_location.png',
                width: 220,
              ),
            ),
            const SizedBox(height: AppDefaults.xlSpace),
            Text(
              "Izinkan kami mengakses data lokasi Anda untuk mengaktifkan pelacakan untuk mengetahui lokasi anda berada di lingkungan bimbel atau tidak, bahkan saat aplikasi ditutup atau tidak digunakan.",
              style: Theme.of(context).textTheme.subtitle1,
            ),
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
                      "No Thanks",
                      style: TextStyle(color: AppColors.textRed),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      onTap();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80, 38),
                      primary: AppColors.backgroundRed,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDefaults.mRadius),
                      ),
                    ),
                    child: const Text("Update Settings"),
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
