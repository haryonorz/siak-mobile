import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/domain/usecases/get_all_guest_student.dart';
import 'package:siak_mobile/domain/usecases/get_user.dart';

part 'all_guest_student_state.dart';

class AllGuestStudentCubit extends Cubit<AllGuestStudentState> {
  final GetAllGuestStudent _getAllGuestStudent;
  final GetUser _getUser;

  AllGuestStudentCubit(
    this._getAllGuestStudent,
    this._getUser,
  ) : super(AllGuestStudentEmpty());

  void fetchData(String idAgenda) async {
    emit(AllGuestStudentLoading());

    final result = await _getUser.execute();

    result.fold(
      (failure) {
        emit(AllGuestStudentError(failure.message));
      },
      (user) async {
        final result = await _getAllGuestStudent.execute(idAgenda);

        result.fold(
          (failure) {
            emit(AllGuestStudentError(failure.message));
          },
          (absensiData) {
            emit(AllGuestStudentHasData(absensiData, user));
            if (absensiData.isEmpty) emit(AllGuestStudentEmpty());
          },
        );
      },
    );
  }
}
