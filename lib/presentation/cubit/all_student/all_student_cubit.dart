import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/domain/usecases/get_all_student.dart';
import 'package:siak_mobile/domain/usecases/get_user.dart';

part 'all_student_state.dart';

class AllStudentCubit extends Cubit<AllStudentState> {
  final GetAllStudent _getAllStudent;
  final GetUser _getUser;

  AllStudentCubit(
    this._getAllStudent,
    this._getUser,
  ) : super(AllStudentEmpty());

  void fetchData(String idAgenda) async {
    emit(AllStudentLoading());

    final result = await _getUser.execute();

    result.fold(
      (failure) {
        emit(AllStudentError(failure.message));
      },
      (user) async {
        final result = await _getAllStudent.execute(idAgenda);

        result.fold(
          (failure) {
            emit(AllStudentError(failure.message));
          },
          (absensiData) {
            emit(AllStudentHasData(absensiData, user));
            if (absensiData.isEmpty) emit(AllStudentEmpty());
          },
        );
      },
    );
  }
}
