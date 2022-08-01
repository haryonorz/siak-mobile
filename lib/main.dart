import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/presentation/cubit/auth/authentication_cubit.dart';
import 'package:siak_mobile/presentation/cubit/sign_in/sign_in_cubit.dart';
import 'package:siak_mobile/presentation/pages/entrypoint/entrypoint_ui.dart';
import 'package:siak_mobile/presentation/pages/sign_in/sign_in_page.dart';
import 'package:siak_mobile/presentation/pages/splash_screen/splash_screen_page.dart';
import 'package:siak_mobile/theme/app_theme.dart';
import 'package:siak_mobile/injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<SignInCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AuthenticationCubit>()..appStated(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Semut',
        theme: appTheme(context),
        onGenerateRoute: RouteGenerator.generateRoute,
        home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return const EntryPointUI();
            }
            if (state is AuthenticationUnauthenticated) {
              return const SignInPage();
            }
            return const SplashScreenPage();
          },
        ),
      ),
    );
  }
}
