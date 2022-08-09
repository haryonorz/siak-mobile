import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/usecases/get_all_guest_student.dart';

part 'all_guest_student_state.dart';

class AllGuestStudentCubit extends Cubit<AllGuestStudentState> {
  final GetAllGuestStudent _getAllGuestStudent;

  AllGuestStudentCubit(
    this._getAllGuestStudent,
  ) : super(AllGuestStudentEmpty());

  void fetchData(String idAgenda) async {
    emit(AllGuestStudentLoading());

    final result = await _getAllGuestStudent.execute(idAgenda);

    result.fold(
      (failure) {
        emit(AllGuestStudentError(failure.message));
      },
      (absensiData) {
        emit(AllGuestStudentHasData(absensiData));
        if (absensiData.isEmpty) emit(AllGuestStudentEmpty());
      },
    );
  }
}
