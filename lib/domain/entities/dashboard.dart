import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/ads.dart';
import 'package:siak_mobile/domain/entities/news.dart';

class Dashboard extends Equatable {
  const Dashboard({
    required this.dataIklan,
    required this.dataNews,
    required this.totalNews,
  });

  final List<Ads> dataIklan;
  final List<News> dataNews;
  final int totalNews;

  @override
  List<Object?> get props => [
        dataIklan,
        dataNews,
        totalNews,
      ];
}
