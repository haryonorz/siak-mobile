import 'package:siak_mobile/domain/entities/user.dart';

abstract class AuthRepository {
  Future<void> persistUser(User user);
  Future<void> deleteUser();
  Future<bool> hasUser();
}
