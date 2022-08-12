import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/usecases/do_accept_request_join.dart';
import 'package:siak_mobile/domain/usecases/do_close_agenda.dart';
import 'package:siak_mobile/domain/usecases/do_update_note_class.dart';

part 'action_agenda_state.dart';

class ActionAgendaCubit extends Cubit<ActionAgendaState> {
  final DoUpdateNoteClass _doUpdateNoteClass;
  final DoCloseAgenda _doCloseAgenda;
  final DoAcceptRequestJoin _doAcceptRequestJoin;

  ActionAgendaCubit(
    this._doUpdateNoteClass,
    this._doCloseAgenda,
    this._doAcceptRequestJoin,
  ) : super(ActionAgendaInitial());

  void acceptRequestJoin(String idAgenda, String noStudent) async {
    emit(ActionAgendaLoading());

    final result = await _doAcceptRequestJoin.execute(idAgenda, noStudent);

    result.fold(
      (failure) {
        emit(ActionAgendaError(failure.message));
      },
      (_) {
        emit(ActionAgendaSuccess());
      },
    );
  }

  void updateNoteClass(String idAgenda, String note) async {
    emit(ActionAgendaLoading());

    final result = await _doUpdateNoteClass.execute(idAgenda, note);

    result.fold(
      (failure) {
        emit(ActionAgendaError(failure.message));
      },
      (_) {
        emit(ActionAgendaSuccess());
      },
    );
  }

  void closeAgenda(String idAgenda) async {
    emit(ActionAgendaLoading());

    final result = await _doCloseAgenda.execute(idAgenda);

    result.fold(
      (failure) {
        emit(ActionAgendaError(failure.message));
      },
      (_) {
        emit(ActionAgendaSuccess());
      },
    );
  }
}
