part of 'all_agenda_bloc.dart';

abstract class AllAgendaEvent extends Equatable {
  const AllAgendaEvent();

  @override
  List<Object> get props => [];
}

class OnFetchData extends AllAgendaEvent {
  final bool isRefresh;

  const OnFetchData({this.isRefresh = false});

  @override
  List<Object> get props => [isRefresh];
}

class OnQueryChanged extends AllAgendaEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
