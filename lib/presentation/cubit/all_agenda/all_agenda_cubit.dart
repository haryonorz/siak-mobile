import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/domain/usecases/get_all_agenda.dart';

part 'all_agenda_state.dart';

class AllAgendaCubit extends Cubit<AllAgendaState> {
  final GetAllAgenda _getAllAgenda;

  AllAgendaCubit(
    this._getAllAgenda,
  ) : super(AllAgendaEmpty());

  void fetchData(String getType) async {
    emit(AllAgendaLoading());

    final result = await _getAllAgenda.execute(getType);

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
}
