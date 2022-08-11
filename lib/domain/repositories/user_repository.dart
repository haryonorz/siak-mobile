import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> doSignIn(String username, String password);
  Future<Either<Failure, bool>> doSignOut();
  Future<Either<Failure, bool>> doChangePassword(
    String oldPassword,
    String newPassword,
  );
}
