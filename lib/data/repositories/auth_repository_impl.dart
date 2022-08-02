import 'package:siak_mobile/data/datasources/db/user_local_data_source.dart';
import 'package:siak_mobile/data/models/user_model.dart';
import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final UserLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<void> persistUser(User user) async {
    await localDataSource.insertUser(UserResponse.fromEntity(user));
  }

  @override
  Future<void> deleteUser() async {
    await localDataSource.removeUser();
  }

  @override
  Future<bool> hasUser() async {
    final result = await localDataSource.getUser();
    await Future.delayed(const Duration(seconds: 3));
    return result != null;
  }
}
