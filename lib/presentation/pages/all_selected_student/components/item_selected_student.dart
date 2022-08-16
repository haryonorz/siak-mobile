import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/presentation/widget/default_user_photo.dart';
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
      leading: absensi.foto != null && absensi.foto != ''
          ? UserPhoto(
              width: 42,
              height: 42,
              url: '${EndPoints.baseUrlPhoto}/profile/${absensi.foto}',
            )
          : const DefaultUserPhoto(width: 42, height: 42),
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
