import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> persistUser(User user) async {}

  @override
  Future<void> deleteUser() async {}

  @override
  Future<bool> hasUser() async {
    return false;
  }
}
