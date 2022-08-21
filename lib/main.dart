import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/common/utils.dart';
import 'package:siak_mobile/presentation/bloc/all_agenda/all_agenda_bloc.dart';
import 'package:siak_mobile/presentation/bloc/all_agenda_history/all_agenda_history_bloc.dart';
import 'package:siak_mobile/presentation/bloc/student_in_class/student_in_class_bloc.dart';
import 'package:siak_mobile/presentation/cubit/accept_request_join/accept_request_join_cubit.dart';
import 'package:siak_mobile/presentation/cubit/action_activity_class/action_activity_class_cubit.dart';
import 'package:siak_mobile/presentation/cubit/action_detail_agenda/action_detail_agenda_cubit.dart';
import 'package:siak_mobile/presentation/cubit/action_situation_class/action_situation_class_cubit.dart';
import 'package:siak_mobile/presentation/cubit/all_guest_student/all_guest_student_cubit.dart';
import 'package:siak_mobile/presentation/cubit/all_request_join/all_request_join_cubit.dart';
import 'package:siak_mobile/presentation/cubit/all_situation_class/all_situation_class_cubit.dart';
import 'package:siak_mobile/presentation/cubit/all_student/all_student_cubit.dart';
import 'package:siak_mobile/presentation/cubit/auth/authentication_cubit.dart';
import 'package:siak_mobile/presentation/cubit/change_password/change_password_cubit.dart';
import 'package:siak_mobile/presentation/cubit/detail_agenda/detail_agenda_cubit.dart';
import 'package:siak_mobile/presentation/cubit/display_camera_attendance_cubit/display_camera_attendance_cubit.dart';
import 'package:siak_mobile/presentation/cubit/info_activity_class/info_activity_class_cubit.dart';
import 'package:siak_mobile/presentation/cubit/info_problem_class/info_problem_class_cubit.dart';
import 'package:siak_mobile/presentation/cubit/profile/profile_cubit.dart';
import 'package:siak_mobile/presentation/cubit/sign_in/sign_in_cubit.dart';
import 'package:siak_mobile/presentation/cubit/sign_out/sign_out_cubit.dart';
import 'package:siak_mobile/presentation/cubit/user/user_cubit.dart';
import 'package:siak_mobile/presentation/cubit/verification_attendance_cubit/action_attendance_cubit.dart';
import 'package:siak_mobile/presentation/pages/home/home_page.dart';
import 'package:siak_mobile/presentation/pages/sign_in/sign_in_page.dart';
import 'package:siak_mobile/presentation/pages/splash_screen/splash_screen_page.dart';
import 'package:siak_mobile/theme/app_theme.dart';
import 'package:siak_mobile/injection.dart' as di;

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();

  _cameras = await availableCameras();
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const MyApp()));
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
          create: (_) => di.locator<SignOutCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ChangePasswordCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AuthenticationCubit>()..appStated(),
        ),
        BlocProvider(
          create: (_) => di.locator<AllAgendaBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AllAgendaHistoryBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailAgendaCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AllRequestJoinCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ActionDetailAgendaCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ActionActivityClassCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AcceptRequestJoinCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<VerificationAttendanceCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DisplayCameraAttendanceCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ActionSituationClassCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AllStudentCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AllGuestStudentCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AllSituationClassCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<InfoActivityClassCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<InfoProblemClassCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<StudentInClassBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<UserCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ProfileCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Semut',
        theme: appTheme(context),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (settings) {
          return RouteGenerator.generateRoute(settings, _cameras);
        },
        home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return const HomePage();
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
