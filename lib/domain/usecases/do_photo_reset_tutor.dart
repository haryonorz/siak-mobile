import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class DoPhotoResetTutor {
  final AgendaRepository repository;

  DoPhotoResetTutor(this.repository);

  Future<Either<Failure, bool>> execute(
    String idAgenda,
    File photo,
    String noStudent,
    String date,
    String time,
  ) {
    return repository.doPhotoResetTutor(
      idAgenda,
      photo,
      noStudent,
      date,
      time,
    );
  }
}
