import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class GetAllAgendaHistory {
  final AgendaRepository repository;

  GetAllAgendaHistory(this.repository);

  Future<Either<Failure, List<Agenda>>> execute(
    String getType, {
    int page = 0,
    String keyword = '',
  }) {
    return repository.getAllAgendaHistory(getType, page, keyword: keyword);
  }
}
