part of 'all_agenda_history_cubit.dart';

abstract class AllAgendaHistoryState extends Equatable {
  const AllAgendaHistoryState();

  @override
  List<Object?> get props => [];
}

class AllAgendaHistoryEmpty extends AllAgendaHistoryState {}

class AllAgendaHistoryLoading extends AllAgendaHistoryState {}

class AllAgendaHistoryError extends AllAgendaHistoryState {
  final String message;

  const AllAgendaHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}

class AllAgendaHistoryHasData extends AllAgendaHistoryState {
  final List<Agenda> agendas;

  const AllAgendaHistoryHasData(this.agendas);

  @override
  List<Object?> get props => [agendas];
}
