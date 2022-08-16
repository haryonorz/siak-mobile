part of 'detail_agenda_cubit.dart';

abstract class DetailAgendaState extends Equatable {
  const DetailAgendaState();

  @override
  List<Object?> get props => [];
}

class DetailAgendaInitial extends DetailAgendaState {}

class DetailAgendaLoading extends DetailAgendaState {}

class DetailAgendaError extends DetailAgendaState {
  final String message;

  const DetailAgendaError(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailAgendaHasData extends DetailAgendaState {
  final DetailAgenda detailAgenda;
  final User user;

  const DetailAgendaHasData(this.detailAgenda, this.user);

  @override
  List<Object?> get props => [detailAgenda, user];
}
