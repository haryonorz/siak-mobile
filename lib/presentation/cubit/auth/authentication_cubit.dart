import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/domain/usecases/do_authentication.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final DoAuthentication _doAuthentication;
  AuthenticationCubit(this._doAuthentication)
      : super(AuthenticationUninitialized());

  void appStated() async {
    final bool hasToken = await _doAuthentication.hasUser();

    if (hasToken) {
      emit(AuthenticationAuthenticated());
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }

  void signIn(User user) async {
    await _doAuthentication.persistUser(user);
    emit(AuthenticationAuthenticated());
  }

  void signOut() async {
    await _doAuthentication.deleteUser();
    emit(AuthenticationUnauthenticated());
  }
}
