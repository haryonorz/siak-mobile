import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/domain/entities/detail_agenda.dart';

abstract class AgendaRepository {
  Future<Either<Failure, List<Agenda>>> getAllAgenda(String getType);
  Future<Either<Failure, DetailAgenda>> getDetailAgenda(String idAgenda);
  Future<Either<Failure, bool>> updateNoteClass(String idAgenda, String note);
}
