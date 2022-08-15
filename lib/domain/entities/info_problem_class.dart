import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/problem_class.dart';

class InfoProblemClass extends Equatable {
  final List<ProblemClass> problemList;
  final String inputDuration;

  const InfoProblemClass({
    required this.problemList,
    required this.inputDuration,
  });

  @override
  List<Object> get props => [problemList, inputDuration];
}
