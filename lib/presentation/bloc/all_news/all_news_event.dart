part of 'all_news_bloc.dart';

abstract class AllNewsEvent extends Equatable {
  const AllNewsEvent();

  @override
  List<Object> get props => [];
}

class OnFetchData extends AllNewsEvent {
  final bool isRefresh;

  const OnFetchData({this.isRefresh = false});

  @override
  List<Object> get props => [isRefresh];
}
