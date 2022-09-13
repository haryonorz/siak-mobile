part of 'all_agenda_history_bloc.dart';

abstract class AllAgendaHistoryEvent extends Equatable {
  const AllAgendaHistoryEvent();

  @override
  List<Object> get props => [];
}

class OnFetchData extends AllAgendaHistoryEvent {
  final bool isRefresh;

  const OnFetchData({this.isRefresh = false});

  @override
  List<Object> get props => [isRefresh];
}

class OnQueryChanged extends AllAgendaHistoryEvent {
  final String query;
  final bool isRefresh;

  const OnQueryChanged(this.query, {this.isRefresh = false});

  @override
  List<Object> get props => [query, isRefresh];
}
