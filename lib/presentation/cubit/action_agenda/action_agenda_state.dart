part of 'action_agenda_cubit.dart';

abstract class ActionAgendaState extends Equatable {
  const ActionAgendaState();

  @override
  List<Object?> get props => [];
}

class ActionAgendaInitial extends ActionAgendaState {}

class ActionAgendaMessage extends ActionAgendaState {
  final String? message;

  const ActionAgendaMessage(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}

class ActionAgendaSuccess extends ActionAgendaState {}
