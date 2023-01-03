import 'package:equatable/equatable.dart';

class News extends Equatable {
  const News({
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
