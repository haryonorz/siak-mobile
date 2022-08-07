import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/repositories/user_repository.dart';

class DoSignOut {
  final UserRepository repository;

  DoSignOut(
    this.repository,
  );

  Future<Either<Failure, bool>> execute() async {
    return repository.doSignOut();
  }
}
