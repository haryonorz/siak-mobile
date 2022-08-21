import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class GetAllAgenda {
  final AgendaRepository repository;

  GetAllAgenda(this.repository);

  Future<Either<Failure, List<Agenda>>> execute(
    String getType, {
    String keyword = '',
  }) {
    return repository.getAllAgenda(getType, keyword: keyword);
  }
}
