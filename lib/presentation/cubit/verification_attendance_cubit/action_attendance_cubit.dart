import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/usecases/do_verification_attends.dart';

part 'action_attendance_state.dart';

class VerificationAttendanceCubit extends Cubit<VerificationAttendanceState> {
  final DoVerificationAttends _doVerificationAttends;

  VerificationAttendanceCubit(
    this._doVerificationAttends,
  ) : super(VerificationAttendanceInitial());

  void verificationAttends(
    String idAgenda,
    String noStudent,
    String verification,
  ) async {
    emit(VerificationAttendanceLoading());

    final result =
        await _doVerificationAttends.execute(idAgenda, noStudent, verification);

    result.fold(
      (failure) {
        emit(VerificationAttendanceError(failure.message));
      },
      (_) {
        emit(VerificationAttendanceSuccess());
      },
    );
  }
}
