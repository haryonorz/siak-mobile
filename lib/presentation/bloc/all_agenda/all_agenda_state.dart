part of 'all_agenda_bloc.dart';

abstract class AllAgendaState extends Equatable {
  const AllAgendaState();

  @override
  List<Object?> get props => [];
}

class AllAgendaEmpty extends AllAgendaState {}

class AllAgendaLoading extends AllAgendaState {}

class AllAgendaError extends AllAgendaState {
  final String message;

  const AllAgendaError(this.message);

  @override
  List<Object?> get props => [message];
}

class AllAgendaHasData extends AllAgendaState {
  final List<Agenda> agendas;

  const AllAgendaHasData(this.agendas);

  @override
  List<Object?> get props => [agendas];
}
