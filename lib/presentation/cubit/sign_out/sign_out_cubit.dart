import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/usecases/do_sign_out.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final DoSignOut _doSignOut;

  SignOutCubit(
    this._doSignOut,
  ) : super(SignOutInitial());

  void doSignOut() async {
    emit(SignOutLoading());

    final result = await _doSignOut.execute();

    result.fold(
      (failure) {
        emit(SignOutError(failure.message));
      },
      (_) {
        emit(SignOutSuccess());
      },
    );
  }
}
