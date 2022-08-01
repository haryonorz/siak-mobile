import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:siak_mobile/data/datasources/remote/auth_remote_data_sources.dart';
import 'package:siak_mobile/data/repositories/user_repository_impl.dart';
import 'package:siak_mobile/domain/repositories/user_repository.dart';
import 'package:siak_mobile/domain/usecases/do_sign_in.dart';
import 'package:siak_mobile/presentation/cubit/sign_in/sign_in_cubit.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => SignInCubit(locator()));

  locator.registerLazySingleton(() => DoSignIn(locator()));

  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: locator()));

  locator.registerLazySingleton<UserRemoteDataSources>(
      () => UserRemoteDataSourcesImpl(client: locator()));

  locator.registerLazySingleton(() => http.Client());
}
