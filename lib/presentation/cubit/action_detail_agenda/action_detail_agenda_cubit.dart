import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/usecases/do_close_agenda.dart';
import 'package:siak_mobile/domain/usecases/do_update_note_class.dart';

part 'action_detail_agenda_state.dart';

class ActionDetailAgendaCubit extends Cubit<ActionDetailAgendaState> {
  final DoUpdateNoteClass _doUpdateNoteClass;
  final DoCloseAgenda _doCloseAgenda;

  ActionDetailAgendaCubit(
    this._doUpdateNoteClass,
    this._doCloseAgenda,
  ) : super(ActionDetailAgendaInitial());

  void updateNoteClass(String idAgenda, String note) async {
    emit(ActionDetailAgendaLoading());

    final result = await _doUpdateNoteClass.execute(idAgenda, note);

    result.fold(
      (failure) {
        emit(ActionDetailAgendaError(failure.message));
      },
      (_) {
        emit(ActionDetailAgendaSuccess());
      },
    );
  }

  void closeAgenda(String idAgenda) async {
    emit(ActionDetailAgendaLoading());

    final result = await _doCloseAgenda.execute(idAgenda);

    result.fold(
      (failure) {
        emit(ActionDetailAgendaError(failure.message));
      },
      (_) {
        emit(ActionDetailAgendaSuccess());
      },
    );
  }
}
