import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/usecases/do_close_agenda.dart';
import 'package:siak_mobile/domain/usecases/do_update_note_class.dart';

part 'action_agenda_state.dart';

class ActionAgendaCubit extends Cubit<ActionAgendaState> {
  final DoUpdateNoteClass _doUpdateNoteClass;
  final DoCloseAgenda _doCloseAgenda;

  ActionAgendaCubit(
    this._doUpdateNoteClass,
    this._doCloseAgenda,
  ) : super(ActionAgendaInitial());

  void updateNoteClass(String idAgenda, String note) async {
    final result = await _doUpdateNoteClass.execute(idAgenda, note);

    result.fold(
      (failure) {
        emit(ActionAgendaMessage(failure.message));
      },
      (_) {
        emit(ActionAgendaSuccess());
      },
    );
  }

  void closeAgenda(String idAgenda) async {
    final result = await _doCloseAgenda.execute(idAgenda);

    result.fold(
      (failure) {
        emit(ActionAgendaMessage(failure.message));
      },
      (_) {
        emit(ActionAgendaSuccess());
      },
    );
  }
}
