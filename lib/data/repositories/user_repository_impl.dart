import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:siak_mobile/common/exceptions.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/data/datasources/db/user_local_data_source.dart';
import 'package:siak_mobile/data/datasources/remote/user_remote_data_source.dart';
import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSources remoteDataSource;
  final UserLocalDataSource localDataSource;
  final FirebaseMessaging messaging;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.messaging,
  });

  @override
  Future<Either<Failure, User>> doSignIn(
      String username, String password) async {
    try {
      String? fcmToken = await messaging.getToken(
        vapidKey:
            'BP5qfZ1xjP8FWKPWONkzuVho5c9hShSKFHhcyaFHsYkrEZQr4upKeiK-kbJbI8wkiRH1JnW-EiaTusLe9yGMXcg',
      );
      final result =
          await remoteDataSource.doSignIn(username, password, fcmToken);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, bool>> doSignOut() async {
    try {
      final user = await localDataSource.getUser();
      if (user != null) {
        final result =
            await remoteDataSource.doSignOut(user.username, user.type);
        return Right(result);
      }
      return Left(ServerFailure('Gagal keluar akun, user tidak ditemukan.'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }
}
