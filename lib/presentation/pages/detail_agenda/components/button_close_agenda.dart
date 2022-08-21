import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/cubit/action_detail_agenda/action_detail_agenda_cubit.dart';

class ButtonCloseAgenda extends StatelessWidget {
  final String idAgenda;

  const ButtonCloseAgenda({Key? key, required this.idAgenda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDefaults.margin),
      child: ElevatedButton(
        onPressed: () =>
            context.read<ActionDetailAgendaCubit>().closeAgenda(idAgenda),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDefaults.mRadius),
          ),
        ),
        child: Text(
          "Tutup Kelas".toUpperCase(),
        ),
      ),
    );
  }
}
