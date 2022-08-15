import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/problem_class.dart';

class ProblemClassResponse extends Equatable {
  const ProblemClassResponse({
    required this.idProblem,
    required this.description,
  });

  final String idProblem;
  final String description;

  factory ProblemClassResponse.fromJson(Map<String, dynamic> json) =>
      ProblemClassResponse(
        idProblem: json["id_problem"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id_problem": idProblem,
        "description": description,
      };

  ProblemClass toEntity() {
    return ProblemClass(
      idProblem: idProblem,
      description: description,
    );
  }

  @override
  List<Object?> get props => [
        idProblem,
        description,
      ];
}
