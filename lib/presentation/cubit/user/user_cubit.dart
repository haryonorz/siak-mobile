import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/domain/usecases/get_user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUser _getUser;

  UserCubit(
    this._getUser,
  ) : super(UserInitial());

  void fetchData() async {
    emit(UserLoading());

    final result = await _getUser.execute();

    result.fold(
      (failure) {
        emit(UserError(failure.message));
      },
      (user) {
        emit(UserHasData(user));
      },
    );
  }
}
