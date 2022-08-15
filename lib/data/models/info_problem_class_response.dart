import 'package:equatable/equatable.dart';
import 'package:siak_mobile/data/models/problem_class_response.dart';
import 'package:siak_mobile/domain/entities/info_problem_class.dart';
import 'package:siak_mobile/domain/entities/problem_class.dart';

class InfoProblemClassResponse extends Equatable {
  final List<ProblemClassResponse> problemList;
  final String inputDuration;

  const InfoProblemClassResponse({
    required this.problemList,
    required this.inputDuration,
  });

  factory InfoProblemClassResponse.fromJson(Map<String, dynamic> json) =>
      InfoProblemClassResponse(
        problemList: List<ProblemClassResponse>.from(
          (json["problem_student"] as List)
              .map((x) => ProblemClassResponse.fromJson(x)),
        ),
        inputDuration: json["input_duration_tutor"],
      );

  Map<String, dynamic> toJson() => {
        "problem_student":
            List<dynamic>.from(problemList.map((x) => x.toJson())),
        "input_duration_tutor": inputDuration,
      };

  InfoProblemClass toEntity() {
    return InfoProblemClass(
      problemList:
          List<ProblemClass>.from(problemList.map((x) => x.toEntity())),
      inputDuration: inputDuration,
    );
  }

  @override
  List<Object> get props => [problemList, inputDuration];
}
