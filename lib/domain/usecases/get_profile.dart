import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/domain/repositories/user_repository.dart';

class GetProfile {
  final UserRepository repository;

  GetProfile(this.repository);

  Future<Either<Failure, User>> execute() {
    return repository.getProfile();
  }
}
