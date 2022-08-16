part of 'info_activity_class_cubit.dart';

abstract class InfoActivityClassState extends Equatable {
  const InfoActivityClassState();

  @override
  List<Object?> get props => [];
}

class InfoActivityClassInitial extends InfoActivityClassState {}

class InfoActivityClassLoading extends InfoActivityClassState {}

class InfoActivityClassError extends InfoActivityClassState {
  final String message;

  const InfoActivityClassError(this.message);

  @override
  List<Object?> get props => [message];
}

class InfoActivityClassHasData extends InfoActivityClassState {
  final List<ActivityClass> activityList;
  final String inputDuration;
  final bool action;
  final bool otherSelected;

  const InfoActivityClassHasData({
    required this.activityList,
    required this.inputDuration,
    this.action = false,
    this.otherSelected = false,
  });

  InfoActivityClassHasData copyWith({
    List<ActivityClass>? activityList,
    String? inputDuration,
    bool? action,
    bool? otherSelected,
  }) {
    return InfoActivityClassHasData(
      activityList: activityList ?? this.activityList,
      inputDuration: inputDuration ?? this.inputDuration,
      action: action ?? this.action,
      otherSelected: otherSelected ?? this.otherSelected,
    );
  }

  @override
  List<Object?> get props => [
        activityList,
        inputDuration,
        action,
        otherSelected,
      ];
}
