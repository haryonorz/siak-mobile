part of 'all_agenda_bloc.dart';

enum AllAgendaStatus { initial, success, failure }

class AllAgendaState extends Equatable {
  const AllAgendaState({
    this.status = AllAgendaStatus.initial,
    this.agendas = const <Agenda>[],
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  final AllAgendaStatus status;
  final List<Agenda> agendas;
  final bool hasReachedMax;
  final String errorMessage;

  AllAgendaState copyWith({
    AllAgendaStatus? status,
    List<Agenda>? agendas,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return AllAgendaState(
      status: status ?? this.status,
      agendas: agendas ?? this.agendas,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, agendas: ${agendas.length} }''';
  }

  @override
  List<Object> get props => [status, agendas, hasReachedMax, errorMessage];
}
