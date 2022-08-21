part of 'all_agenda_history_bloc.dart';

abstract class AllAgendaHistoryEvent extends Equatable {
  const AllAgendaHistoryEvent();

  @override
  List<Object> get props => [];
}

class OnFetchData extends AllAgendaHistoryEvent {}

class OnQueryChanged extends AllAgendaHistoryEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
