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
  ) : super(const AllAgendaHistoryState()) {
    on<OnFetchData>(
      _onFetchData,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 500))
            .asyncExpand(mapper);
      },
    );
    on<OnQueryChanged>(
      _onQueryChanged,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 500))
            .asyncExpand(mapper);
      },
    );
  }

  Future<void> _onFetchData(
    OnFetchData event,
    Emitter<AllAgendaHistoryState> emit,
  ) async {
    if (state.hasReachedMax && !event.isRefresh) return;
    try {
      if (event.isRefresh || state.status == AllAgendaHistoryStatus.initial) {
        final result = await _getAllAgendaHistory.execute('all');

        result.fold(
          (failure) {
            return emit(
              state.copyWith(
                status: AllAgendaHistoryStatus.failure,
                errorMessage: failure.message,
              ),
            );
          },
          (agendas) {
            return emit(
              state.copyWith(
                status: AllAgendaHistoryStatus.success,
                agendas: agendas,
                hasReachedMax: false,
              ),
            );
          },
        );
      }
      final result =
          await _getAllAgendaHistory.execute('all', page: state.agendas.length);

      result.fold(
        (failure) {
          return emit(
            state.copyWith(
              status: AllAgendaHistoryStatus.failure,
              errorMessage: failure.message,
            ),
          );
        },
        (agendas) {
          agendas.isEmpty
              ? emit(state.copyWith(hasReachedMax: true))
              : emit(
                  state.copyWith(
                    status: AllAgendaHistoryStatus.success,
                    agendas: List.of(state.agendas)..addAll(agendas),
                    hasReachedMax: false,
                  ),
                );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AllAgendaHistoryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onQueryChanged(
    OnQueryChanged event,
    Emitter<AllAgendaHistoryState> emit,
  ) async {
    final query = event.query;
    if (state.hasReachedMax && !event.isRefresh) return;
    try {
      if (event.isRefresh || state.status == AllAgendaHistoryStatus.initial) {
        final result =
            await _getAllAgendaHistory.execute('search', keyword: query);

        result.fold(
          (failure) {
            return emit(
              state.copyWith(
                status: AllAgendaHistoryStatus.failure,
                errorMessage: failure.message,
              ),
            );
          },
          (agendas) {
            return emit(
              state.copyWith(
                status: AllAgendaHistoryStatus.success,
                agendas: agendas,
                hasReachedMax: false,
              ),
            );
          },
        );
      }
      final result = await _getAllAgendaHistory.execute('search',
          keyword: query, page: state.agendas.length);

      result.fold(
        (failure) {
          return emit(
            state.copyWith(
              status: AllAgendaHistoryStatus.failure,
              errorMessage: failure.message,
            ),
          );
        },
        (agendas) {
          agendas.isEmpty
              ? emit(state.copyWith(hasReachedMax: true))
              : emit(
                  state.copyWith(
                    status: AllAgendaHistoryStatus.success,
                    agendas: List.of(state.agendas)..addAll(agendas),
                    hasReachedMax: false,
                  ),
                );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AllAgendaHistoryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
