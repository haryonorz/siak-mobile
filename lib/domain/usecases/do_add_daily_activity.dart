import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class DoAddDailyActivity {
  final AgendaRepository repository;

  DoAddDailyActivity(this.repository);

  Future<Either<Failure, bool>> execute(
    String idAgenda,
    String idActivity,
    String activityText,
    String otherActivity,
  ) {
    return repository.doAddDailyActivity(
      idAgenda,
      idActivity,
      activityText,
      otherActivity,
    );
  }
}
