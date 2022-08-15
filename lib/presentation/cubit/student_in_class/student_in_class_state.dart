part of 'student_in_class_cubit.dart';

abstract class StudentInClassState extends Equatable {
  const StudentInClassState();

  @override
  List<Object?> get props => [];
}

class StudentInClassEmpty extends StudentInClassState {}

class StudentInClassLoading extends StudentInClassState {}

class StudentInClassError extends StudentInClassState {
  final String message;

  const StudentInClassError(this.message);

  @override
  List<Object?> get props => [message];
}

class StudentInClassHasData extends StudentInClassState {
  final List<Absensi> absensi;

  const StudentInClassHasData(this.absensi);

  @override
  List<Object?> get props => [absensi];
}
