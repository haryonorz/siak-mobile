import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/news.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class GetAllNews {
  final AgendaRepository repository;

  GetAllNews(this.repository);

  Future<Either<Failure, List<News>>> execute({
    int page = 0,
  }) {
    return repository.getAllNews(page);
  }
}
