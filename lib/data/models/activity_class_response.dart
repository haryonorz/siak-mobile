import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/activity_class.dart';

class ActivityClassResponse extends Equatable {
  const ActivityClassResponse({
    required this.idProblem,
    required this.description,
  });

  final String idProblem;
  final String description;

  factory ActivityClassResponse.fromJson(Map<String, dynamic> json) =>
      ActivityClassResponse(
        idProblem: json["id_aktivitas"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id_aktivitas": idProblem,
        "description": description,
      };

  ActivityClass toEntity() {
    return ActivityClass(
      idActivity: idProblem,
      description: description,
    );
  }

  @override
  List<Object?> get props => [
        idProblem,
        description,
      ];
}
