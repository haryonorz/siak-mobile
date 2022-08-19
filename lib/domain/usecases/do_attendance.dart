import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class DoAttendance {
  final AgendaRepository repository;

  DoAttendance(this.repository);

  Future<Either<Failure, bool>> execute(
    String idAgenda,
    File photo,
    String noStudent,
    String date,
    String time,
    String latitude,
    String longitude,
  ) {
    return repository.doAttendance(
      idAgenda,
      photo,
      noStudent,
      date,
      time,
      latitude,
      longitude,
    );
  }
}
