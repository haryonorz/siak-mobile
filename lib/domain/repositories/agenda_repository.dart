import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/domain/entities/detail_agenda.dart';
import 'package:siak_mobile/domain/entities/info_activity_class.dart';
import 'package:siak_mobile/domain/entities/info_problem_class.dart';

abstract class AgendaRepository {
  Future<Either<Failure, List<Agenda>>> getAllAgenda(String getType);
  Future<Either<Failure, List<Agenda>>> getAllAgendaHistory(String getType);
  Future<Either<Failure, DetailAgenda>> getDetailAgenda(String idAgenda);
  Future<Either<Failure, List<Absensi>>> getAllRequestJoin(String idAgenda);
  Future<Either<Failure, List<Absensi>>> getAllStudent(String idAgenda);
  Future<Either<Failure, List<Absensi>>> getAllGuestStudent(String idAgenda);
  Future<Either<Failure, List<Absensi>>> getAllSituationClass(String idAgenda);
  Future<Either<Failure, InfoActivityClass>> getInfoActivityClass();
  Future<Either<Failure, InfoProblemClass>> getInfoProblemClass();
  Future<Either<Failure, List<Absensi>>> getStudentInClass(String idAgenda);

  Future<Either<Failure, bool>> doAddDailyActivity(
    String idAgenda,
    String idActivity,
    String activityText,
    String otherActivity,
  );
  Future<Either<Failure, bool>> doAcceptRequestJoin(
      String idAgenda, String noStudent);
  Future<Either<Failure, bool>> doAddSituationClass(
    String idAgenda,
    String noStudent,
    String idProblem,
    String problemStudent,
  );
  Future<Either<Failure, bool>> doUpdateNoteClass(String idAgenda, String note);
  Future<Either<Failure, bool>> doCloseAgenda(String idAgenda);
}
