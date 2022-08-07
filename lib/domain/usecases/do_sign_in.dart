import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/domain/repositories/user_repository.dart';

class DoSignIn {
  final UserRepository repository;

  DoSignIn(this.repository);

  Future<Either<Failure, User>> execute(String username, String password) {
    return repository.doSignIn(username, password);
  }
}
