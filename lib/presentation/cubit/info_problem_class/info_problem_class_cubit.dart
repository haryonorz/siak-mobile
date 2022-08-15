import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/info_problem_class.dart';
import 'package:siak_mobile/domain/entities/problem_class.dart';
import 'package:siak_mobile/domain/usecases/get_info_problem_class.dart';

part 'info_problem_class_state.dart';

class InfoProblemClassCubit extends Cubit<InfoProblemClassState> {
  final GetInfoProblemClass _getInfoProblemClass;

  InfoProblemClassCubit(
    this._getInfoProblemClass,
  ) : super(InfoProblemClassInitial());

  void fetchData() async {
    emit(InfoProblemClassLoading());

    final result = await _getInfoProblemClass.execute();

    result.fold(
      (failure) {
        emit(InfoProblemClassError(failure.message));
      },
      (infoProblemClass) {
        emit(InfoProblemClassHasData(
          problemList: infoProblemClass.problemList,
          inputDuration: infoProblemClass.inputDuration,
        ));
      },
    );
  }

  void selectedItem(ProblemClass problemClass) async {
    List<ProblemClass> dataList =
        (state as InfoProblemClassHasData).problemList;
    bool action = (state as InfoProblemClassHasData).action;
    final index = dataList
        .indexWhere((element) => element.idProblem == problemClass.idProblem);
    dataList[index] = problemClass;

    final otherItem =
        dataList.where((element) => element.idProblem == '-').first;

    //problem list still bug, so i make action for render ui, need fixed;
    emit((state as InfoProblemClassHasData).copyWith(
      problemList: dataList,
      action: !action,
      otherSelected: otherItem.selected == true,
    ));
  }
}
