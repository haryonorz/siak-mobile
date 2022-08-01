import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/exceptions.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/data/datasources/remote/auth_remote_data_source.dart';
import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSources remoteDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, User>> doSignIn(
      String username, String password) async {
    try {
      final result = await remoteDataSource.doSignIn(username, password);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
