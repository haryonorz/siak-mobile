import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/news.dart';

class NewsModel extends Equatable {
  const NewsModel({
    required this.newsId,
    required this.photoCover,
    required this.categoryId,
    required this.categoryName,
    required this.title,
    required this.content,
    required this.status,
    required this.addby,
    required this.addate,
  });

  final String newsId;
  final String photoCover;
  final String categoryId;
  final String categoryName;
  final String title;
  final String content;
  final String status;
  final String addby;
  final DateTime addate;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        newsId: json["news_id"],
        photoCover: json["photo_cover"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        title: json["title"],
        content: json["content"],
        status: json["status"],
        addby: json["addby"],
        addate: DateTime.parse(json["addate"]),
      );

  News toEntity() {
    return News(
      newsId: newsId,
      photoCover: photoCover,
      categoryId: categoryId,
      categoryName: categoryName,
      title: title,
      content: content,
      status: status,
      addby: addby,
      addate: addate,
    );
  }

  @override
  List<Object?> get props => [
        newsId,
        photoCover,
        categoryId,
        categoryName,
        title,
        content,
        status,
        addby,
        addate,
      ];
}
