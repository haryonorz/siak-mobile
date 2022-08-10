import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/usecases/get_all_situation_class.dart';

part 'all_situation_class_state.dart';

class AllSituationClassCubit extends Cubit<AllSituationClassState> {
  final GetAllSituationClass _getAllSituationClass;

  AllSituationClassCubit(
    this._getAllSituationClass,
  ) : super(AllSituationClassEmpty());

  void fetchData(String idAgenda) async {
    emit(AllSituationClassLoading());

    final result = await _getAllSituationClass.execute(idAgenda);

    result.fold(
      (failure) {
        emit(AllSituationClassError(failure.message));
      },
      (absensiData) {
        emit(AllSituationClassHasData(absensiData));
        if (absensiData.isEmpty) emit(AllSituationClassEmpty());
      },
    );
  }
}
