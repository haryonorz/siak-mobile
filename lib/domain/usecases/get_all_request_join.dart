import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class GetAllRequestJoin {
  final AgendaRepository repository;

  GetAllRequestJoin(this.repository);

  Future<Either<Failure, List<Absensi>>> execute(String idAgenda) {
    return repository.getAllRequestJoin(idAgenda);
  }
}
