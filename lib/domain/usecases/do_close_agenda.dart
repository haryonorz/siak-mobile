import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class DoCloseAgenda {
  final AgendaRepository repository;

  DoCloseAgenda(this.repository);

  Future<Either<Failure, bool>> execute(String idAgenda) {
    return repository.doCloseAgenda(idAgenda);
  }
}
