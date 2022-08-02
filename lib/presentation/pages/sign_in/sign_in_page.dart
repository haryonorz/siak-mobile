import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/cubit/auth/authentication_cubit.dart';
import 'package:siak_mobile/presentation/cubit/sign_in/sign_in_cubit.dart';
import 'package:siak_mobile/presentation/pages/sign_in/components/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.backgroundBlue,
      ),
      child: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            context.read<AuthenticationCubit>().signIn(state.user);
          }
          if (state is SignInError) {
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
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            bottom: false,
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: AppDefaults.margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Center(
                    child: Image.asset(AppImages.logoStrategis),
                  ),
                  const Spacer(),
                  Text(
                    "Sign In",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: AppDefaults.xlSpace),
                  SignInForm(),
                  const SizedBox(height: 64),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
