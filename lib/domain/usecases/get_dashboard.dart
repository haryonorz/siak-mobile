import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/dashboard.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class GetDashboard {
  final AgendaRepository repository;

  GetDashboard(this.repository);

  Future<Either<Failure, Dashboard>> execute() {
    return repository.getDashboard();
  }
}
