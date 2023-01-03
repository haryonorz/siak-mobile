import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/domain/usecases/get_profile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfile _getProfile;

  ProfileCubit(
    this._getProfile,
  ) : super(ProfileInitial());

  void fetchData() async {
    emit(ProfileLoading());

    Future.delayed(const Duration(seconds: 1), () async {
      final result = await _getProfile.execute();

      result.fold(
        (failure) {
          emit(ProfileError(failure.message));
        },
        (profile) {
          emit(ProfileHasData(profile));
        },
      );
    });
  }
}
