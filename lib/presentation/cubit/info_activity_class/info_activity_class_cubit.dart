import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/activity_class.dart';
import 'package:siak_mobile/domain/usecases/get_info_activity_class.dart';

part 'info_activity_class_state.dart';

class InfoActivityClassCubit extends Cubit<InfoActivityClassState> {
  final GetInfoActivityClass _getInfoActivityClass;

  InfoActivityClassCubit(
    this._getInfoActivityClass,
  ) : super(InfoActivityClassInitial());

  void fetchData() async {
    emit(InfoActivityClassLoading());

    final result = await _getInfoActivityClass.execute();

    result.fold(
      (failure) {
        emit(InfoActivityClassError(failure.message));
      },
      (infoActivityClass) {
        emit(InfoActivityClassHasData(
          activityList: infoActivityClass.activityList,
          inputDuration: infoActivityClass.inputDuration,
        ));
      },
    );
  }

  void selectedItem(ActivityClass activityClass) async {
    List<ActivityClass> dataList =
        (state as InfoActivityClassHasData).activityList;
    bool action = (state as InfoActivityClassHasData).action;
    final index = dataList.indexWhere(
        (element) => element.idActivity == activityClass.idActivity);
    dataList[index] = activityClass;

    final otherItem =
        dataList.where((element) => element.idActivity == '-').first;

    //problem list still bug, so i make action for render ui, need fixed;
    emit((state as InfoActivityClassHasData).copyWith(
      activityList: dataList,
      action: !action,
      otherSelected: otherItem.selected == true,
    ));
  }
}
