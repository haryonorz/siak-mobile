part of 'action_situation_class_cubit.dart';

abstract class ActionSituationClassState extends Equatable {
  const ActionSituationClassState();

  @override
  List<Object?> get props => [];
}

class ActionSituationClassInitial extends ActionSituationClassState {}

class ActionSituationClassLoading extends ActionSituationClassState {}

class ActionSituationClassError extends ActionSituationClassState {
  final String message;

  const ActionSituationClassError(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}

class ActionSituationClassSuccess extends ActionSituationClassState {}
