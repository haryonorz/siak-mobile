part of 'all_student_cubit.dart';

abstract class AllStudentState extends Equatable {
  const AllStudentState();

  @override
  List<Object?> get props => [];
}

class AllStudentEmpty extends AllStudentState {}

class AllStudentLoading extends AllStudentState {}

class AllStudentError extends AllStudentState {
  final String message;

  const AllStudentError(this.message);

  @override
  List<Object?> get props => [message];
}

class AllStudentHasData extends AllStudentState {
  final List<Absensi> absensi;

  const AllStudentHasData(this.absensi);

  @override
  List<Object?> get props => [absensi];
}
