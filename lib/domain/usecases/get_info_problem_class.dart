import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/info_problem_class.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class GetInfoProblemClass {
  final AgendaRepository repository;

  GetInfoProblemClass(this.repository);

  Future<Either<Failure, InfoProblemClass>> execute() {
    return repository.getInfoProblemClass();
  }
}
