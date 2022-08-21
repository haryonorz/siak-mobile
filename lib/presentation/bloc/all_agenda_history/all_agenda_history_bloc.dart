import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/domain/usecases/get_all_agenda_history.dart';

part 'all_agenda_history_state.dart';
part 'all_agenda_history_event.dart';

class AllAgendaHistoryBloc
    extends Bloc<AllAgendaHistoryEvent, AllAgendaHistoryState> {
  final GetAllAgendaHistory _getAllAgendaHistory;

  AllAgendaHistoryBloc(
    this._getAllAgendaHistory,
  ) : super(AllAgendaHistoryEmpty()) {
    on<OnFetchData>(_onFetchData);
    on<OnQueryChanged>(
      _onQueryChanged,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 500))
            .asyncExpand(mapper);
      },
    );
  }

  void _onFetchData(
    OnFetchData event,
    Emitter<AllAgendaHistoryState> emit,
  ) async {
    emit(AllAgendaHistoryLoading());

    final result = await _getAllAgendaHistory.execute('all');

    result.fold(
      (failure) {
        emit(AllAgendaHistoryError(failure.message));
      },
      (moviesData) {
        emit(AllAgendaHistoryHasData(moviesData));
        if (moviesData.isEmpty) emit(AllAgendaHistoryEmpty());
      },
    );
  }

  void _onQueryChanged(
    OnQueryChanged event,
    Emitter<AllAgendaHistoryState> emit,
  ) async {
    final query = event.query;
    emit(AllAgendaHistoryLoading());

    final result = await _getAllAgendaHistory.execute('search', keyword: query);

    result.fold(
      (failure) => emit(AllAgendaHistoryError(failure.message)),
      (agendaData) {
        emit(AllAgendaHistoryHasData(agendaData));
        if (agendaData.isEmpty) emit(AllAgendaHistoryEmpty());
      },
    );
  }
}
