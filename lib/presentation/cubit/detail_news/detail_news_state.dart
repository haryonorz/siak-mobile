part of 'detail_news_cubit.dart';

abstract class DetailNewsState extends Equatable {
  const DetailNewsState();

  @override
  List<Object?> get props => [];
}

class DetailNewsInitial extends DetailNewsState {}

class DetailNewsLoading extends DetailNewsState {}

class DetailNewsError extends DetailNewsState {
  final String message;

  const DetailNewsError(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailNewsHasData extends DetailNewsState {
  final News news;

  const DetailNewsHasData(this.news);

  @override
  List<Object?> get props => [news];
}
