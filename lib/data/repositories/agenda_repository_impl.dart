import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/exceptions.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/data/datasources/db/user_local_data_source.dart';
import 'package:siak_mobile/data/datasources/remote/agenda_remote_data_source.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/domain/entities/detail_agenda.dart';
import 'package:siak_mobile/domain/entities/info_activity_class.dart';
import 'package:siak_mobile/domain/entities/info_problem_class.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class AgendaRepositoryImpl extends AgendaRepository {
  final AgendaRemoteDataSources remoteDataSource;
  final UserLocalDataSource localDataSource;

  AgendaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Agenda>>> getAllAgenda(String getType) async {
    try {
      final user = await localDataSource.getUser();
      if (user != null) {
        final result = await remoteDataSource.getAllAgenda(
          user.username,
          user.type,
          getType,
        );
        return Right(result.map((model) => model.toEntity()).toList());
      }
      return Left(ServerFailure('User tidak ditemukan.'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, List<Agenda>>> getAllAgendaHistory(
      String getType) async {
    try {
      final user = await localDataSource.getUser();
      if (user != null) {
        final result = await remoteDataSource.getAllAgendaHistory(
          user.username,
          user.type,
          getType,
        );
        return Right(result.map((model) => model.toEntity()).toList());
      }
      return Left(ServerFailure('User tidak ditemukan.'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, DetailAgenda>> getDetailAgenda(String idAgenda) async {
    try {
      final user = await localDataSource.getUser();
      if (user != null) {
        final result = await remoteDataSource.getDetailAgenda(
          idAgenda,
          user.username,
          user.type,
        );
        return Right(result.toEntity());
      }
      return Left(ServerFailure('User tidak ditemukan.'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, List<Absensi>>> getAllRequestJoin(
      String idAgenda) async {
    try {
      final result = await remoteDataSource.getAllRequestJoin(idAgenda);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, List<Absensi>>> getAllStudent(String idAgenda) async {
    try {
      final result = await remoteDataSource.getAllStudent(idAgenda);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, List<Absensi>>> getAllGuestStudent(
      String idAgenda) async {
    try {
      final result = await remoteDataSource.getAllGuestStudent(idAgenda);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, List<Absensi>>> getAllSituationClass(
      String idAgenda) async {
    try {
      final result = await remoteDataSource.getAllSituationClass(idAgenda);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, InfoActivityClass>> getInfoActivityClass() async {
    try {
      final result = await remoteDataSource.getInfoActivityClass();
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, InfoProblemClass>> getInfoProblemClass() async {
    try {
      final result = await remoteDataSource.getInfoProblemClass();
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, List<Absensi>>> getStudentInClass(
    String idAgenda,
  ) async {
    try {
      final result = await remoteDataSource.getStudentInClass(idAgenda);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, bool>> doAddDailyActivity(
    String idAgenda,
    String idActivity,
    String activityText,
    String otherActivity,
  ) async {
    try {
      final result = await remoteDataSource.doAddDailyActivity(
        idAgenda,
        idActivity,
        activityText,
        otherActivity,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, bool>> doAcceptRequestJoin(
    String idAgenda,
    String noStudent,
  ) async {
    try {
      final result = await remoteDataSource.doAcceptRequestJoin(
        idAgenda,
        noStudent,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, bool>> doAddSituationClass(
    String idAgenda,
    String noStudent,
    String idProblem,
    String problemStudent,
  ) async {
    try {
      final result = await remoteDataSource.doAddSituationClass(
        idAgenda,
        noStudent,
        idProblem,
        problemStudent,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, bool>> doUpdateNoteClass(
    String idAgenda,
    String note,
  ) async {
    try {
      final result = await remoteDataSource.doUpdateNoteClass(
        idAgenda,
        note,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }

  @override
  Future<Either<Failure, bool>> doCloseAgenda(String idAgenda) async {
    try {
      final result = await remoteDataSource.doCloseAgenda(idAgenda);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan.'));
    }
  }
}
