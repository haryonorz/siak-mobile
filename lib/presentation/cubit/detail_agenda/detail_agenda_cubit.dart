import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/detail_agenda.dart';
import 'package:siak_mobile/domain/usecases/get_detail_agenda.dart';

part 'detail_agenda_state.dart';

class DetailAgendaCubit extends Cubit<DetailAgendaState> {
  final GetDetailAgenda _getDetailAgenda;

  DetailAgendaCubit(
    this._getDetailAgenda,
  ) : super(DetailAgendaInitial());

  void fetchData(String idAgenda) async {
    emit(DetailAgendaLoading());

    final result = await _getDetailAgenda.execute(idAgenda);

    result.fold(
      (failure) {
        emit(DetailAgendaError(failure.message));
      },
      (detailAgenda) {
        emit(DetailAgendaHasData(detailAgenda));
      },
    );
  }
}
