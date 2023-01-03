import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/news.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class GetDetailNews {
  final AgendaRepository repository;

  GetDetailNews(this.repository);

  Future<Either<Failure, News>> execute(String newsId) {
    return repository.getDetailNews(newsId);
  }
}
