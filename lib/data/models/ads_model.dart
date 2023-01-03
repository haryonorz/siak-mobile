import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/ads.dart';

class AdsModel extends Equatable {
  const AdsModel({
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

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
        adsId: json["ads_id"],
        photoCover: json["photo_cover"],
        title: json["title"],
        content: json["content"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        status: json["status"],
        addby: json["addby"],
        addate: DateTime.parse(json["addate"]),
      );

  Ads toEntity() {
    return Ads(
      adsId: adsId,
      photoCover: photoCover,
      title: title,
      content: content,
      startDate: startDate,
      endDate: endDate,
      status: status,
      addby: addby,
      addate: addate,
    );
  }

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
