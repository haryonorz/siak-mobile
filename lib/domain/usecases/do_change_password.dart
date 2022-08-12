import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/repositories/user_repository.dart';

class DoChangePassword {
  final UserRepository repository;

  DoChangePassword(this.repository);

  Future<Either<Failure, bool>> execute(
      String oldPassword, String newPassword) {
    return repository.doChangePassword(oldPassword, newPassword);
  }
}
