import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/domain/entities/detail_agenda.dart';

abstract class AgendaRepository {
  Future<Either<Failure, List<Agenda>>> getAllAgenda(String getType);
  Future<Either<Failure, List<Agenda>>> getAllAgendaHistory(String getType);
  Future<Either<Failure, DetailAgenda>> getDetailAgenda(String idAgenda);
  Future<Either<Failure, List<Absensi>>> getAllRequestJoin(String idAgenda);
  Future<Either<Failure, bool>> doUpdateNoteClass(String idAgenda, String note);
  Future<Either<Failure, bool>> doCloseAgenda(String idAgenda);
  Future<Either<Failure, List<Absensi>>> getAllStudent(String idAgenda);
  Future<Either<Failure, List<Absensi>>> getAllGuestStudent(String idAgenda);
  Future<Either<Failure, List<Absensi>>> getAllSituationClass(String idAgenda);
}
