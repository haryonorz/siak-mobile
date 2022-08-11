import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/usecases/do_accept_request_join.dart';

part 'accept_request_join_state.dart';

class AcceptRequestJoinCubit extends Cubit<AcceptRequestJoinState> {
  final DoAcceptRequestJoin _doAcceptRequestJoin;

  AcceptRequestJoinCubit(
    this._doAcceptRequestJoin,
  ) : super(AcceptRequestJoinInitial());

  void acceptRequestJoin(String idAgenda, String noStudent) async {
    final result = await _doAcceptRequestJoin.execute(idAgenda, noStudent);

    result.fold(
      (failure) {
        emit(AcceptRequestJoinError(failure.message));
      },
      (_) {
        emit(AcceptRequestJoinSuccess());
      },
    );
  }
}
