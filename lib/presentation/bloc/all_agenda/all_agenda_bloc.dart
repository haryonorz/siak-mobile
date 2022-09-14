import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/domain/usecases/get_all_agenda.dart';

part 'all_agenda_state.dart';
part 'all_agenda_event.dart';

class AllAgendaBloc extends Bloc<AllAgendaEvent, AllAgendaState> {
  final GetAllAgenda _getAllAgenda;

  AllAgendaBloc(
    this._getAllAgenda,
  ) : super(const AllAgendaState()) {
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
    Emitter<AllAgendaState> emit,
  ) async {
    if (state.hasReachedMax && !event.isRefresh) return;
    try {
      if (event.isRefresh || state.status == AllAgendaStatus.initial) {
        final result = await _getAllAgenda.execute('all');

        result.fold(
          (failure) {
            return emit(
              state.copyWith(
                status: AllAgendaStatus.failure,
                errorMessage: failure.message,
              ),
            );
          },
          (agendas) {
            return emit(
              state.copyWith(
                status: AllAgendaStatus.success,
                agendas: agendas,
                hasReachedMax: false,
              ),
            );
          },
        );
      }
      final result =
          await _getAllAgenda.execute('all', page: state.agendas.length);

      result.fold(
        (failure) {
          return emit(
            state.copyWith(
              status: AllAgendaStatus.failure,
              errorMessage: failure.message,
            ),
          );
        },
        (agendas) {
          agendas.isEmpty
              ? emit(state.copyWith(hasReachedMax: true))
              : emit(
                  state.copyWith(
                    status: AllAgendaStatus.success,
                    agendas: List.of(state.agendas)..addAll(agendas),
                    hasReachedMax: false,
                  ),
                );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AllAgendaStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onQueryChanged(
    OnQueryChanged event,
    Emitter<AllAgendaState> emit,
  ) async {
    final query = event.query;
    if (state.hasReachedMax && !event.isRefresh) return;
    try {
      if (event.isRefresh || state.status == AllAgendaStatus.initial) {
        final result = await _getAllAgenda.execute('search', keyword: query);

        result.fold(
          (failure) {
            return emit(
              state.copyWith(
                status: AllAgendaStatus.failure,
                errorMessage: failure.message,
              ),
            );
          },
          (agendas) {
            return emit(
              state.copyWith(
                status: AllAgendaStatus.success,
                agendas: agendas,
                hasReachedMax: false,
              ),
            );
          },
        );
      }
      final result = await _getAllAgenda.execute('search',
          keyword: query, page: state.agendas.length);

      result.fold(
        (failure) {
          return emit(
            state.copyWith(
              status: AllAgendaStatus.failure,
              errorMessage: failure.message,
            ),
          );
        },
        (agendas) {
          agendas.isEmpty
              ? emit(state.copyWith(hasReachedMax: true))
              : emit(
                  state.copyWith(
                    status: AllAgendaStatus.success,
                    agendas: List.of(state.agendas)..addAll(agendas),
                    hasReachedMax: false,
                  ),
                );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AllAgendaStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
