import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/usecases/get_student_in_class.dart';

part 'student_in_class_state.dart';

class StudentInClassCubit extends Cubit<StudentInClassState> {
  final GetStudentInClass _getGetStudentInClass;

  StudentInClassCubit(
    this._getGetStudentInClass,
  ) : super(StudentInClassEmpty());

  void fetchData(String idAgenda) async {
    emit(StudentInClassLoading());

    final result = await _getGetStudentInClass.execute(idAgenda);

    result.fold(
      (failure) {
        emit(StudentInClassError(failure.message));
      },
      (absensiData) {
        emit(StudentInClassHasData(absensiData));
        if (absensiData.isEmpty) emit(StudentInClassEmpty());
      },
    );
  }
}
