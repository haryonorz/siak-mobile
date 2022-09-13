part of 'all_agenda_history_bloc.dart';

enum AllAgendaHistoryStatus { initial, success, failure }

class AllAgendaHistoryState extends Equatable {
  const AllAgendaHistoryState({
    this.status = AllAgendaHistoryStatus.initial,
    this.agendas = const <Agenda>[],
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  final AllAgendaHistoryStatus status;
  final List<Agenda> agendas;
  final bool hasReachedMax;
  final String errorMessage;

  AllAgendaHistoryState copyWith({
    AllAgendaHistoryStatus? status,
    List<Agenda>? agendas,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return AllAgendaHistoryState(
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
