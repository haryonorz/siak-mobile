import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class DoVerificationAttends {
  final AgendaRepository repository;

  DoVerificationAttends(this.repository);

  Future<Either<Failure, bool>> execute(
    String idAgenda,
    String noStudent,
    String verification,
  ) {
    return repository.doVerificationAttends(
      idAgenda,
      noStudent,
      verification,
    );
  }
}
