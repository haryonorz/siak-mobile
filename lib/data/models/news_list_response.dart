import 'package:equatable/equatable.dart';
import 'package:siak_mobile/data/models/news_model.dart';

class NewsListResponse extends Equatable {
  final List<NewsModel> newsList;

  const NewsListResponse({required this.newsList});

  factory NewsListResponse.fromJson(Map<String, dynamic> json) =>
      NewsListResponse(
        newsList: List<NewsModel>.from(
            (json["data_news"] as List).map((x) => NewsModel.fromJson(x))),
      );
  @override
  List<Object> get props => [newsList];
}
