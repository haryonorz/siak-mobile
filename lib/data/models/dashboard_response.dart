import 'package:equatable/equatable.dart';
import 'package:siak_mobile/data/models/ads_model.dart';
import 'package:siak_mobile/data/models/news_model.dart';

class DashboardResponse extends Equatable {
  const DashboardResponse({
    required this.dataIklan,
    required this.dataNews,
    required this.totalNews,
  });

  final List<AdsModel> dataIklan;
  final List<NewsModel> dataNews;
  final int totalNews;

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      DashboardResponse(
        dataIklan: List<AdsModel>.from(
            json["data_iklan"].map((x) => AdsModel.fromJson(x))),
        dataNews: List<NewsModel>.from(
            json["data_news"].map((x) => NewsModel.fromJson(x))),
        totalNews: json["total_news"],
      );

  @override
  List<Object?> get props => [
        dataIklan,
        dataNews,
        totalNews,
      ];
}
