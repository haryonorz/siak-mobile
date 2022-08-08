import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class DoUpdateNoteClass {
  final AgendaRepository repository;

  DoUpdateNoteClass(this.repository);

  Future<Either<Failure, bool>> execute(String idAgenda, String note) {
    return repository.updateNoteClass(idAgenda, note);
  }
}
