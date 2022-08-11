import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/presentation/cubit/sign_out/sign_out_cubit.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundBlue,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                AppImages.logoStrategis,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Beranda'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Riwayat Agenda'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.agendaHistory);
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text('Profil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.profile);
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Keluar'),
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
        ],
      ),
    );
  }
}
