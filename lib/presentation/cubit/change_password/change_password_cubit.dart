import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/usecases/do_change_password.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final DoChangePassword _doChangePassword;

  ChangePasswordCubit(
    this._doChangePassword,
  ) : super(ChangePasswordInitial());

  void doChangePassword(
    String oldPassword,
    String newPassword,
  ) async {
    emit(ChangePasswordLoading());

    final result = await _doChangePassword.execute(oldPassword, newPassword);

    result.fold(
      (failure) {
        emit(ChangePasswordError(failure.message));
      },
      (_) {
        emit(ChangePasswordSuccess());
      },
    );
  }
}
