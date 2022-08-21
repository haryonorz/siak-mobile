part of 'action_activity_class_cubit.dart';

abstract class ActionActivityClassState extends Equatable {
  const ActionActivityClassState();

  @override
  List<Object?> get props => [];
}

class ActionActivityClassInitial extends ActionActivityClassState {}

class ActionActivityClassLoading extends ActionActivityClassState {}

class ActionActivityClassError extends ActionActivityClassState {
  final String message;

  const ActionActivityClassError(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}

class ActionActivityClassSuccess extends ActionActivityClassState {}
