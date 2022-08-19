import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/cubit/auth/authentication_cubit.dart';
import 'package:siak_mobile/presentation/cubit/sign_out/sign_out_cubit.dart';
import 'package:siak_mobile/presentation/pages/profile/components/header_profile.dart';
import 'package:siak_mobile/presentation/pages/profile/components/list_menu_profile.dart';
import 'package:siak_mobile/presentation/pages/profile/components/version_app.dart';

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
            const HeaderProfile(),
            const SizedBox(width: AppDefaults.xlSpace),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: AppDefaults.padding),
                color: AppColors.backgroundDarkBlue,
                child: const ListMenuProfile(),
              ),
            ),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: AppDefaults.padding),
              color: AppColors.backgroundDarkBlue,
              child: const Center(
                child: VersionApp(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
