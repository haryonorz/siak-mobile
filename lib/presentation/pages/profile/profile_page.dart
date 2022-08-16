import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/presentation/cubit/auth/authentication_cubit.dart';
import 'package:siak_mobile/presentation/cubit/sign_out/sign_out_cubit.dart';
import 'package:siak_mobile/presentation/widget/custom_field.dart';
import 'package:siak_mobile/presentation/widget/default_user_photo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignOutCubit, SignOutState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          context.read<AuthenticationCubit>().signOut();
          Navigator.pop(context);
        }
        if (state is SignOutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.textWhite),
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDefaults.sRadius)),
              elevation: 0,
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Profil'),
          systemOverlayStyle: AppDefaults.statusBarDarkBlue,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(AppDefaults.margin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hasda',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: AppDefaults.lSpace),
                        CustomField(
                          label: "Kode Tutor: ",
                          value: '-',
                          valueStyle: Theme.of(context).textTheme.subtitle2,
                        ),
                        const SizedBox(height: 2),
                        CustomField(
                          label: "No Hp: ",
                          value: '-',
                          valueStyle: Theme.of(context).textTheme.subtitle2,
                        ),
                        const SizedBox(height: 2),
                        CustomField(
                          label: "Kelas: ",
                          value: '-',
                          valueStyle: Theme.of(context).textTheme.subtitle2,
                        ),
                        const SizedBox(height: 2),
                        CustomField(
                          label: "Mata Pelajaran: ",
                          value: '-',
                          valueStyle: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppDefaults.lSpace),
                  Column(
                    children: [
                      const DefaultUserPhoto(width: 80, height: 80),
                      const SizedBox(height: AppDefaults.lSpace),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          Routes.editProfile,
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(90, 38),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppDefaults.mRadius),
                          ),
                        ),
                        child: const Text("Edit Profil"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppDefaults.xlSpace),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: AppDefaults.padding),
                color: AppColors.backgroundDarkBlue,
                child: Column(
                  children: [
                    Material(
                      color: AppColors.backgroundBlue,
                      child: ListTile(
                        leading: const Icon(Icons.key_rounded),
                        title: const Text('Ubah Password'),
                        onTap: () =>
                            Navigator.pushNamed(context, Routes.changePassword),
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
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: AppDefaults.padding),
              color: AppColors.backgroundDarkBlue,
              child: const Center(
                child: Text('Version v1.0.0'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
