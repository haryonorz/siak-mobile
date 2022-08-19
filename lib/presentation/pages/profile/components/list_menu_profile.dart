import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/presentation/cubit/sign_out/sign_out_cubit.dart';

class ListMenuProfile extends StatelessWidget {
  const ListMenuProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.backgroundBlue,
          child: ListTile(
            leading: const Icon(Icons.key_rounded),
            title: const Text('Ubah Password'),
            onTap: () => Navigator.pushNamed(context, Routes.changePassword),
          ),
        ),
        Material(
          color: AppColors.backgroundBlue,
          child: ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Keluar'),
            tileColor: AppColors.backgroundBlue,
            onTap: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: 'Keluar',
                message: 'Anda yakin ingin keluar dari aplikasi?',
                okLabel: 'Yes',
                cancelLabel: 'No',
              );
              if (result == OkCancelResult.ok) {
                context.read<SignOutCubit>().doSignOut();
              }
            },
          ),
        ),
      ],
    );
  }
}
