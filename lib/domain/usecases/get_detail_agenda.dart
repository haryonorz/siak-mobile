import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/detail_agenda.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class GetDetailAgenda {
  final AgendaRepository repository;

  GetDetailAgenda(this.repository);

  Future<Either<Failure, DetailAgenda>> execute(String idAgenda) {
    return repository.getDetailAgenda(idAgenda);
  }
}
