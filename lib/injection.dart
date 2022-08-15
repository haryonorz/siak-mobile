import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:siak_mobile/data/datasources/db/helper/database_helper.dart';
import 'package:siak_mobile/data/datasources/db/user_local_data_source.dart';
import 'package:siak_mobile/data/datasources/remote/agenda_remote_data_source.dart';
import 'package:siak_mobile/data/datasources/remote/user_remote_data_source.dart';
import 'package:siak_mobile/data/repositories/agenda_repository_impl.dart';
import 'package:siak_mobile/data/repositories/auth_repository_impl.dart';
import 'package:siak_mobile/data/repositories/user_repository_impl.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';
import 'package:siak_mobile/domain/repositories/auth_repository.dart';
import 'package:siak_mobile/domain/repositories/user_repository.dart';
import 'package:siak_mobile/domain/usecases/do_accept_request_join.dart';
import 'package:siak_mobile/domain/usecases/do_add_situation_class.dart';
import 'package:siak_mobile/domain/usecases/do_authentication.dart';
import 'package:siak_mobile/domain/usecases/do_change_password.dart';
import 'package:siak_mobile/domain/usecases/do_close_agenda.dart';
import 'package:siak_mobile/domain/usecases/do_sign_in.dart';
import 'package:siak_mobile/domain/usecases/do_sign_out.dart';
import 'package:siak_mobile/domain/usecases/do_update_note_class.dart';
import 'package:siak_mobile/domain/usecases/get_all_agenda.dart';
import 'package:siak_mobile/domain/usecases/get_all_agenda_history.dart';
import 'package:siak_mobile/domain/usecases/get_all_guest_student.dart';
import 'package:siak_mobile/domain/usecases/get_all_request_join.dart';
import 'package:siak_mobile/domain/usecases/get_all_situation_class.dart';
import 'package:siak_mobile/domain/usecases/get_all_student.dart';
import 'package:siak_mobile/domain/usecases/get_detail_agenda.dart';
import 'package:siak_mobile/domain/usecases/get_info_problem_class.dart';
import 'package:siak_mobile/domain/usecases/get_student_in_class.dart';
import 'package:siak_mobile/presentation/cubit/action_agenda/action_agenda_cubit.dart';
import 'package:siak_mobile/presentation/cubit/action_situation_class/action_situation_class_cubit.dart';
import 'package:siak_mobile/presentation/cubit/all_agenda/all_agenda_cubit.dart';
import 'package:siak_mobile/presentation/cubit/all_agenda_history/all_agenda_history_cubit.dart';
import 'package:siak_mobile/presentation/cubit/all_guest_student/all_guest_student_cubit.dart';
import 'package:siak_mobile/presentation/cubit/all_request_join/all_request_join_cubit.dart';
import 'package:siak_mobile/presentation/cubit/all_situation_class/all_situation_class_cubit.dart';
import 'package:siak_mobile/presentation/cubit/all_student/all_student_cubit.dart';
import 'package:siak_mobile/presentation/cubit/auth/authentication_cubit.dart';
import 'package:siak_mobile/presentation/cubit/change_password/change_password_cubit.dart';
import 'package:siak_mobile/presentation/cubit/detail_agenda/detail_agenda_cubit.dart';
import 'package:siak_mobile/presentation/cubit/info_problem_class/info_problem_class_cubit.dart';
import 'package:siak_mobile/presentation/cubit/sign_in/sign_in_cubit.dart';
import 'package:siak_mobile/presentation/cubit/sign_out/sign_out_cubit.dart';
import 'package:siak_mobile/presentation/cubit/student_in_class/student_in_class_cubit.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => SignInCubit(locator()));
  locator.registerFactory(() => SignOutCubit(locator()));
  locator.registerFactory(() => ChangePasswordCubit(locator()));
  locator.registerFactory(() => AuthenticationCubit(locator()));
  locator.registerFactory(() => AllAgendaCubit(locator()));
  locator.registerFactory(() => AllAgendaHistoryCubit(locator()));
  locator.registerFactory(() => DetailAgendaCubit(locator()));
  locator.registerFactory(() => AllRequestJoinCubit(locator()));
  locator.registerFactory(() => ActionAgendaCubit(
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(() => ActionSituationClassCubit(locator()));
  locator.registerFactory(() => AllStudentCubit(locator()));
  locator.registerFactory(() => AllGuestStudentCubit(locator()));
  locator.registerFactory(() => AllSituationClassCubit(locator()));
  locator.registerFactory(() => InfoProblemClassCubit(locator()));
  locator.registerFactory(() => StudentInClassCubit(locator()));

  locator.registerLazySingleton(() => DoSignIn(locator()));
  locator.registerLazySingleton(() => DoSignOut(locator()));
  locator.registerLazySingleton(() => DoChangePassword(locator()));
  locator.registerLazySingleton(() => DoAuthentication(locator()));
  locator.registerLazySingleton(() => GetAllAgenda(locator()));
  locator.registerLazySingleton(() => GetAllAgendaHistory(locator()));
  locator.registerLazySingleton(() => GetDetailAgenda(locator()));
  locator.registerLazySingleton(() => GetAllRequestJoin(locator()));
  locator.registerLazySingleton(() => DoAcceptRequestJoin(locator()));
  locator.registerLazySingleton(() => DoUpdateNoteClass(locator()));
  locator.registerLazySingleton(() => DoCloseAgenda(locator()));
  locator.registerLazySingleton(() => GetAllStudent(locator()));
  locator.registerLazySingleton(() => GetAllGuestStudent(locator()));
  locator.registerLazySingleton(() => GetAllSituationClass(locator()));
  locator.registerLazySingleton(() => GetInfoProblemClass(locator()));
  locator.registerLazySingleton(() => DoAddSituationClass(locator()));
  locator.registerLazySingleton(() => GetStudentInClass(locator()));

  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        messaging: locator(),
      ));
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(localDataSource: locator()));
  locator.registerLazySingleton<AgendaRepository>(() => AgendaRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
      ));

  locator.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<UserRemoteDataSources>(
      () => UserRemoteDataSourcesImpl(client: locator()));
  locator.registerLazySingleton<AgendaRemoteDataSources>(
      () => AgendaRemoteDataSourcesImpl(client: locator()));

  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<FirebaseMessaging>(
      () => FirebaseMessaging.instance);
}
