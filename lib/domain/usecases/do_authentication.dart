import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/domain/repositories/auth_repository.dart';

class DoAuthentication {
  final AuthRepository repository;

  DoAuthentication(this.repository);

  Future<bool> hasUser() {
    return repository.hasUser();
  }

  Future<void> deleteUser() {
    return repository.deleteUser();
  }

  Future<void> persistUser(User user) {
    return repository.persistUser(user);
  }
}
