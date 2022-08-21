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
  ) : super(AllAgendaEmpty()) {
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
    Emitter<AllAgendaState> emit,
  ) async {
    emit(AllAgendaLoading());

    final result = await _getAllAgenda.execute('all');

    result.fold(
      (failure) {
        emit(AllAgendaError(failure.message));
      },
      (moviesData) {
        emit(AllAgendaHasData(moviesData));
        if (moviesData.isEmpty) emit(AllAgendaEmpty());
      },
    );
  }

  void _onQueryChanged(
    OnQueryChanged event,
    Emitter<AllAgendaState> emit,
  ) async {
    final query = event.query;
    emit(AllAgendaLoading());

    final result = await _getAllAgenda.execute('search', keyword: query);

    result.fold(
      (failure) => emit(AllAgendaError(failure.message)),
      (agendaData) {
        emit(AllAgendaHasData(agendaData));
        if (agendaData.isEmpty) emit(AllAgendaEmpty());
      },
    );
  }
}
