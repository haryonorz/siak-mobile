import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/usecases/get_student_in_class.dart';

part 'student_in_class_event.dart';
part 'student_in_class_state.dart';

class StudentInClassBloc
    extends Bloc<StudentInClassEvent, StudentInClassState> {
  final GetStudentInClass _getGetStudentInClass;

  StudentInClassBloc(
    this._getGetStudentInClass,
  ) : super(StudentInClassEmpty()) {
    on<OnFetchData>(_onFetchData);
    on<OnQueryChanged>(
      _onQueryChanged,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 500))
            .asyncExpand(mapper);
      },
    );
  }

  void _onFetchData(
    OnFetchData event,
    Emitter<StudentInClassState> emit,
  ) async {
    final idAgenda = event.idAgenda;
    emit(StudentInClassLoading());

    final result = await _getGetStudentInClass.execute(idAgenda, 'all');

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

  void _onQueryChanged(
    OnQueryChanged event,
    Emitter<StudentInClassState> emit,
  ) async {
    final idAgenda = event.idAgenda;
    final query = event.query;
    emit(StudentInClassLoading());

    final result =
        await _getGetStudentInClass.execute(idAgenda, 'search', keyword: query);

    result.fold(
      (failure) => emit(StudentInClassError(failure.message)),
      (agendaData) {
        emit(StudentInClassHasData(agendaData));
        if (agendaData.isEmpty) emit(StudentInClassEmpty());
      },
    );
  }
}
