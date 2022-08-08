import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/usecases/do_update_note_class.dart';

part 'action_agenda_state.dart';

class ActionAgendaCubit extends Cubit<ActionAgendaState> {
  final DoUpdateNoteClass _doUpdateNoteClass;

  ActionAgendaCubit(
    this._doUpdateNoteClass,
  ) : super(ActionAgendaInitial());

  void updateNoteClass(String idAgenda, String note) async {
    final result = await _doUpdateNoteClass.execute(idAgenda, note);

    result.fold(
      (failure) {
        emit(ActionAgendaMessage(failure.message));
      },
      (success) {
        emit(ActionAgendaSuccess());
      },
    );
  }
}
