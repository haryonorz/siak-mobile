part of 'action_attendance_cubit.dart';

abstract class VerificationAttendanceState extends Equatable {
  const VerificationAttendanceState();

  @override
  List<Object?> get props => [];
}

class VerificationAttendanceInitial extends VerificationAttendanceState {}

class VerificationAttendanceLoading extends VerificationAttendanceState {}

class VerificationAttendanceError extends VerificationAttendanceState {
  final String message;

  const VerificationAttendanceError(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}

class VerificationAttendanceSuccess extends VerificationAttendanceState {}
