part of 'action_agenda_cubit.dart';

abstract class ActionAgendaState extends Equatable {
  const ActionAgendaState();

  @override
  List<Object?> get props => [];
}

class ActionAgendaInitial extends ActionAgendaState {}

class ActionAgendaLoading extends ActionAgendaState {}

class ActionAgendaError extends ActionAgendaState {
  final String message;

  const ActionAgendaError(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}

class ActionAgendaSuccess extends ActionAgendaState {}
