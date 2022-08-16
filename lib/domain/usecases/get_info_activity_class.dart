import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/info_activity_class.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class GetInfoActivityClass {
  final AgendaRepository repository;

  GetInfoActivityClass(this.repository);

  Future<Either<Failure, InfoActivityClass>> execute() {
    return repository.getInfoActivityClass();
  }
}
