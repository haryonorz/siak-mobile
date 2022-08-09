part of 'all_guest_student_cubit.dart';

abstract class AllGuestStudentState extends Equatable {
  const AllGuestStudentState();

  @override
  List<Object?> get props => [];
}

class AllGuestStudentEmpty extends AllGuestStudentState {}

class AllGuestStudentLoading extends AllGuestStudentState {}

class AllGuestStudentError extends AllGuestStudentState {
  final String message;

  const AllGuestStudentError(this.message);

  @override
  List<Object?> get props => [message];
}

class AllGuestStudentHasData extends AllGuestStudentState {
  final List<Absensi> absensi;

  const AllGuestStudentHasData(this.absensi);

  @override
  List<Object?> get props => [absensi];
}
