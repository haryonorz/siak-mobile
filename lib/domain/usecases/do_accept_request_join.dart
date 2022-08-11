import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class DoAcceptRequestJoin {
  final AgendaRepository repository;

  DoAcceptRequestJoin(this.repository);

  Future<Either<Failure, bool>> execute(String idAgenda, String noStudent) {
    return repository.doAcceptRequestJoin(idAgenda, noStudent);
  }
}
