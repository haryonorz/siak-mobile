part of 'action_detail_agenda_cubit.dart';

abstract class ActionDetailAgendaState extends Equatable {
  const ActionDetailAgendaState();

  @override
  List<Object?> get props => [];
}

class ActionDetailAgendaInitial extends ActionDetailAgendaState {}

class ActionDetailAgendaLoading extends ActionDetailAgendaState {}

class ActionDetailAgendaError extends ActionDetailAgendaState {
  final String message;

  const ActionDetailAgendaError(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}

class ActionDetailAgendaSuccess extends ActionDetailAgendaState {}
