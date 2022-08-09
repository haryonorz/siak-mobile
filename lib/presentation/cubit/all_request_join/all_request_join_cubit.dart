import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/usecases/get_all_request_join.dart';

part 'all_request_join_state.dart';

class AllRequestJoinCubit extends Cubit<AllRequestJoinState> {
  final GetAllRequestJoin _getAllRequestJoin;

  AllRequestJoinCubit(
    this._getAllRequestJoin,
  ) : super(AllRequestJoinEmpty());

  void fetchData(String idAgenda) async {
    emit(AllRequestJoinLoading());

    final result = await _getAllRequestJoin.execute(idAgenda);

    result.fold(
      (failure) {
        emit(AllRequestJoinError(failure.message));
      },
      (absensiData) {
        emit(AllRequestJoinHasData(absensiData));
        if (absensiData.isEmpty) emit(AllRequestJoinEmpty());
      },
    );
  }
}
