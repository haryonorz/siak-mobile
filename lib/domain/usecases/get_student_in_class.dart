import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class GetStudentInClass {
  final AgendaRepository repository;

  GetStudentInClass(this.repository);

  Future<Either<Failure, List<Absensi>>> execute(
    String idAgenda,
    String getType, {
    String keyword = '',
  }) {
    return repository.getStudentInClass(
      idAgenda,
      getType,
      keyword: keyword,
    );
  }
}
