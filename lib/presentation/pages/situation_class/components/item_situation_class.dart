import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/presentation/widget/custom_field.dart';
import 'package:siak_mobile/presentation/widget/default_user_photo.dart';
import 'package:siak_mobile/presentation/widget/user_photo.dart';

class ItemSituationClass extends StatefulWidget {
  final Absensi absensi;

  const ItemSituationClass({Key? key, required this.absensi}) : super(key: key);

  @override
  State<ItemSituationClass> createState() => _ItemSituationClassState();
}

class _ItemSituationClassState extends State<ItemSituationClass> {
  final FlipCardController _controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        _controller.toggleCard();
      },
      leading: FlipCard(
        onFlipDone: (status) {},
        direction: FlipDirection.HORIZONTAL,
        controller: _controller,
        front: widget.absensi.foto.isNotEmpty
            ? UserPhoto(
                width: 42,
                height: 42,
                url: '${EndPoints.baseUrlPhoto}/profile/${widget.absensi.foto}',
              )
            : const DefaultUserPhoto(
                width: 42,
                height: 42,
                photoPreview: false,
              ),
        back: Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.backgroundRed,
          ),
          child: const Icon(Icons.done),
        ),
      ),
      title: Text(
        widget.absensi.namaSiswa,
        style: Theme.of(context)
            .textTheme
            .subtitle1
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: CustomField(
        label: "Masalah: ",
        value: widget.absensi.masalahSiswa ?? '-',
        valueStyle: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}
