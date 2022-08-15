import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/problem_class.dart';
import 'package:siak_mobile/domain/usecases/do_add_situation_class.dart';

part 'action_situation_class_state.dart';

class ActionSituationClassCubit extends Cubit<ActionSituationClassState> {
  final DoAddSituationClass _doAddSituationClass;

  ActionSituationClassCubit(
    this._doAddSituationClass,
  ) : super(ActionSituationClassInitial());

  void addSituationClass(
    String idAgenda,
    String noStudent,
    String note,
    List<ProblemClass> problemStudent,
  ) async {
    emit(ActionSituationClassLoading());
    if (problemStudent.isEmpty) {
      emit(const ActionSituationClassError(
          'Permasalahan siswa tidak boleh kosong'));
    } else {
      // final result = await _doAddSituationClass.execute(
      //   idAgenda,
      //   noStudent,
      //   idAgenda,
      //   noStudent,
      // );

      // result.fold(
      //   (failure) {
      //     emit(ActionSituationClassError(failure.message));
      //   },
      //   (_) {
      //     emit(ActionSituationClassSuccess());
      //   },
      // );
    }
  }
}
