import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/activity_class.dart';
import 'package:siak_mobile/domain/usecases/do_accept_request_join.dart';
import 'package:siak_mobile/domain/usecases/do_add_daily_activity.dart';
import 'package:siak_mobile/domain/usecases/do_close_agenda.dart';
import 'package:siak_mobile/domain/usecases/do_update_note_class.dart';

part 'action_agenda_state.dart';

class ActionAgendaCubit extends Cubit<ActionAgendaState> {
  final DoAddDailyActivity _doAddDailyActivity;
  final DoAcceptRequestJoin _doAcceptRequestJoin;
  final DoUpdateNoteClass _doUpdateNoteClass;
  final DoCloseAgenda _doCloseAgenda;

  ActionAgendaCubit(
    this._doAddDailyActivity,
    this._doAcceptRequestJoin,
    this._doUpdateNoteClass,
    this._doCloseAgenda,
  ) : super(ActionAgendaInitial());

  void addDailyActivity(
    String idAgenda,
    List<ActivityClass> activity,
    String otherActivity,
  ) async {
    emit(ActionAgendaLoading());
    if (activity.isEmpty) {
      emit(const ActionAgendaError('Aktifitas harian tidak boleh kosong'));
    } else {
      String idActivity = '';
      String activityText = '';
      String otherActivityText = '';

      activity.asMap().forEach((key, value) {
        idActivity = '$idActivity${value.idActivity}';

        if (activityText.isEmpty) {
          activityText = value.description;
        } else {
          activityText = '$activityText, ${value.description}';
        }
        if (value.idActivity == '-') otherActivityText = otherActivity;
      });
      final result = await _doAddDailyActivity.execute(
        idAgenda,
        idActivity,
        activityText,
        otherActivityText,
      );

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
