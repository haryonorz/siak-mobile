import 'package:equatable/equatable.dart';
import 'package:siak_mobile/data/models/activity_class_response.dart';
import 'package:siak_mobile/domain/entities/activity_class.dart';
import 'package:siak_mobile/domain/entities/info_activity_class.dart';

class InfoActivityClassResponse extends Equatable {
  final List<ActivityClassResponse> activityList;
  final String inputDuration;

  const InfoActivityClassResponse({
    required this.activityList,
    required this.inputDuration,
  });

  factory InfoActivityClassResponse.fromJson(Map<String, dynamic> json) =>
      InfoActivityClassResponse(
        activityList: List<ActivityClassResponse>.from(
          (json["aktivitas"] as List)
              .map((x) => ActivityClassResponse.fromJson(x)),
        ),
        inputDuration: json["input_duration_tutor"],
      );

  Map<String, dynamic> toJson() => {
        "aktivitas": List<dynamic>.from(activityList.map((x) => x.toJson())),
        "input_duration_tutor": inputDuration,
      };

  InfoActivityClass toEntity() {
    return InfoActivityClass(
      activityList:
          List<ActivityClass>.from(activityList.map((x) => x.toEntity())),
      inputDuration: inputDuration,
    );
  }

  @override
  List<Object> get props => [activityList, inputDuration];
}
