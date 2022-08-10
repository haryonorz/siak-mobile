import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/domain/usecases/get_all_agenda_history.dart';

part 'all_agenda_history_state.dart';

class AllAgendaHistoryCubit extends Cubit<AllAgendaHistoryState> {
  final GetAllAgendaHistory _getAllAgendaHistory;

  AllAgendaHistoryCubit(
    this._getAllAgendaHistory,
  ) : super(AllAgendaHistoryEmpty());

  void fetchData(String getType) async {
    emit(AllAgendaHistoryLoading());

    final result = await _getAllAgendaHistory.execute(getType);

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
}
