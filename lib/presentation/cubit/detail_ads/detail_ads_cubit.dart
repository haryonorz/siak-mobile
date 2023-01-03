import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/ads.dart';
import 'package:siak_mobile/domain/usecases/get_detail_ads.dart';

part 'detail_ads_state.dart';

class DetailAdsCubit extends Cubit<DetailAdsState> {
  final GetDetailAds _getDetailAds;

  DetailAdsCubit(this._getDetailAds) : super(DetailAdsInitial());

  void fetchData(String adsId) async {
    emit(DetailAdsLoading());

    final result = await _getDetailAds.execute(adsId);

    result.fold(
      (failure) {
        emit(DetailAdsError(failure.message));
      },
      (ads) {
        emit(DetailAdsHasData(ads));
      },
    );
  }
}
