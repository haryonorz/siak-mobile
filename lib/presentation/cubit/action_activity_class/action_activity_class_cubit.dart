import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/activity_class.dart';
import 'package:siak_mobile/domain/usecases/do_add_daily_activity.dart';

part 'action_activity_class_state.dart';

class ActionActivityClassCubit extends Cubit<ActionActivityClassState> {
  final DoAddDailyActivity _doAddDailyActivity;

  ActionActivityClassCubit(
    this._doAddDailyActivity,
  ) : super(ActionActivityClassInitial());

  void addDailyActivity(
    String idAgenda,
    List<ActivityClass> activity,
    String otherActivity,
  ) async {
    emit(ActionActivityClassLoading());
    if (activity.isEmpty) {
      emit(const ActionActivityClassError(
          'Aktifitas harian tidak boleh kosong'));
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
          emit(ActionActivityClassError(failure.message));
        },
        (_) {
          emit(ActionActivityClassSuccess());
        },
      );
    }
  }
}
