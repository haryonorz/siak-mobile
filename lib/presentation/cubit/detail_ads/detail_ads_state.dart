part of 'detail_ads_cubit.dart';

abstract class DetailAdsState extends Equatable {
  const DetailAdsState();

  @override
  List<Object?> get props => [];
}

class DetailAdsInitial extends DetailAdsState {}

class DetailAdsLoading extends DetailAdsState {}

class DetailAdsError extends DetailAdsState {
  final String message;

  const DetailAdsError(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailAdsHasData extends DetailAdsState {
  final Ads ads;

  const DetailAdsHasData(this.ads);

  @override
  List<Object?> get props => [ads];
}
