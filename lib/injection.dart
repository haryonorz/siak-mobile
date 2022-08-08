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
import 'package:siak_mobile/domain/usecases/do_authentication.dart';
import 'package:siak_mobile/domain/usecases/do_sign_in.dart';
import 'package:siak_mobile/domain/usecases/do_sign_out.dart';
import 'package:siak_mobile/domain/usecases/do_update_note_class.dart';
import 'package:siak_mobile/domain/usecases/get_all_agenda.dart';
import 'package:siak_mobile/domain/usecases/get_detail_agenda.dart';
import 'package:siak_mobile/presentation/cubit/action_agenda/action_agenda_cubit.dart';
import 'package:siak_mobile/presentation/cubit/all_agenda/all_agenda_cubit.dart';
import 'package:siak_mobile/presentation/cubit/auth/authentication_cubit.dart';
import 'package:siak_mobile/presentation/cubit/detail_agenda/detail_agenda_cubit.dart';
import 'package:siak_mobile/presentation/cubit/sign_in/sign_in_cubit.dart';
import 'package:siak_mobile/presentation/cubit/sign_out/sign_out_cubit.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => SignInCubit(locator()));
  locator.registerFactory(() => SignOutCubit(locator()));
  locator.registerFactory(() => AuthenticationCubit(locator()));
  locator.registerFactory(() => AllAgendaCubit(locator()));
  locator.registerFactory(() => DetailAgendaCubit(locator()));
  locator.registerFactory(() => ActionAgendaCubit(locator()));

  locator.registerLazySingleton(() => DoSignIn(locator()));
  locator.registerLazySingleton(() => DoSignOut(locator()));
  locator.registerLazySingleton(() => DoAuthentication(locator()));
  locator.registerLazySingleton(() => GetAllAgenda(locator()));
  locator.registerFactory(() => GetDetailAgenda(locator()));
  locator.registerFactory(() => DoUpdateNoteClass(locator()));

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
