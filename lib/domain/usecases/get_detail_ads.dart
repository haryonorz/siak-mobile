import 'package:dartz/dartz.dart';
import 'package:siak_mobile/common/failure.dart';
import 'package:siak_mobile/domain/entities/ads.dart';
import 'package:siak_mobile/domain/repositories/agenda_repository.dart';

class GetDetailAds {
  final AgendaRepository repository;

  GetDetailAds(this.repository);

  Future<Either<Failure, Ads>> execute(String adsId) {
    return repository.getDetailAds(adsId);
  }
}
