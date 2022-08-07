import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/domain/usecases/do_sign_in.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final DoSignIn _doSignIn;

  SignInCubit(
    this._doSignIn,
  ) : super(SignInInitial());

  void doSignIn(String email, String password) async {
    emit(SignInLoading());

    final result = await _doSignIn.execute(email, password);

    result.fold(
      (failure) {
        emit(SignInError(failure.message));
      },
      (token) {
        emit(SignInSuccess(token));
      },
    );
  }
}
