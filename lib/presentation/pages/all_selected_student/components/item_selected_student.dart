import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/presentation/widget/user_photo.dart';

class ItemSelectedStudent extends StatelessWidget {
  final Absensi absensi;
  final bool selected;
  final Function()? onTap;

  const ItemSelectedStudent(
      {Key? key, required this.absensi, this.selected = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: UserPhoto(
        width: 42,
        height: 42,
        url: absensi.foto != null &&
                absensi.foto != '' &&
                absensi.foto != 'http://siak.bimbel-strategis.com/uploads/'
            ? absensi.foto.toString()
            : '',
      ),
      title: Text(
        absensi.namaSiswa,
        style: Theme.of(context)
            .textTheme
            .subtitle1
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        absensi.pilKelas,
        style: Theme.of(context)
            .textTheme
            .subtitle2
            ?.copyWith(color: AppColors.textGrey),
      ),
      trailing: SizedBox(
        width: 24,
        child: selected
            ? const Icon(
                Icons.done,
                color: AppColors.iconRed,
                size: 24,
              )
            : Container(),
      ),
    );
  }
}
