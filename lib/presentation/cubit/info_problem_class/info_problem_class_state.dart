part of 'info_problem_class_cubit.dart';

abstract class InfoProblemClassState extends Equatable {
  const InfoProblemClassState();

  @override
  List<Object?> get props => [];
}

class InfoProblemClassInitial extends InfoProblemClassState {}

class InfoProblemClassLoading extends InfoProblemClassState {}

class InfoProblemClassError extends InfoProblemClassState {
  final String message;

  const InfoProblemClassError(this.message);

  @override
  List<Object?> get props => [message];
}

class InfoProblemClassHasData extends InfoProblemClassState {
  final List<ProblemClass> problemList;
  final String inputDuration;
  final bool action;
  final bool otherSelected;

  const InfoProblemClassHasData({
    required this.problemList,
    required this.inputDuration,
    this.action = false,
    this.otherSelected = false,
  });

  InfoProblemClassHasData copyWith({
    List<ProblemClass>? problemList,
    String? inputDuration,
    bool? action,
    bool? otherSelected,
  }) {
    return InfoProblemClassHasData(
      problemList: problemList ?? this.problemList,
      inputDuration: inputDuration ?? this.inputDuration,
      action: action ?? this.action,
      otherSelected: otherSelected ?? this.otherSelected,
    );
  }

  @override
  List<Object?> get props => [
        problemList,
        inputDuration,
        action,
        otherSelected,
      ];
}
