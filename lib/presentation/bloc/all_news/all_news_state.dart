part of 'all_news_bloc.dart';

enum AllNewsStatus { initial, success, failure }

class AllNewsState extends Equatable {
  const AllNewsState({
    this.status = AllNewsStatus.initial,
    this.news = const <News>[],
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  final AllNewsStatus status;
  final List<News> news;
  final bool hasReachedMax;
  final String errorMessage;

  AllNewsState copyWith({
    AllNewsStatus? status,
    List<News>? news,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return AllNewsState(
      status: status ?? this.status,
      news: news ?? this.news,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, news: ${news.length} }''';
  }

  @override
  List<Object> get props => [status, news, hasReachedMax, errorMessage];
}
