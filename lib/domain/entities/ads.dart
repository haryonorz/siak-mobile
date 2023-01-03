import 'package:equatable/equatable.dart';

class Ads extends Equatable {
  const Ads({
    required this.adsId,
    required this.photoCover,
    required this.title,
    required this.content,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.addby,
    required this.addate,
  });

  final String adsId;
  final String photoCover;
  final String title;
  final String content;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String addby;
  final DateTime addate;

  @override
  List<Object?> get props => [
        adsId,
        photoCover,
        title,
        content,
        startDate,
        endDate,
        status,
        addby,
        addate,
      ];
}
