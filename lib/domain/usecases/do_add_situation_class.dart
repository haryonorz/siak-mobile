import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class DoAddSituationClass {
  final AgendaRepository repository;

  DoAddSituationClass(this.repository);

  Future<Either<Failure, bool>> execute(
    String idAgenda,
    String noStudent,
    String idProblem,
    String problemStudent,
  ) {
    return repository.doAddSituationClass(
      idAgenda,
      noStudent,
      idProblem,
      problemStudent,
    );
  }
}
