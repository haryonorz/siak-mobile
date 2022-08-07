import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';

abstract class AgendaRepository {
  Future<Either<Failure, List<Agenda>>> getAllAgenda(String getType);
}
