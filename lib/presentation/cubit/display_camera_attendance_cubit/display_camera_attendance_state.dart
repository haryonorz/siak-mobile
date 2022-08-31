part of 'display_camera_attendance_cubit.dart';

abstract class DisplayCameraAttendanceState extends Equatable {
  const DisplayCameraAttendanceState();

  @override
  List<Object?> get props => [];
}

class DisplayCameraAttendanceInitial extends DisplayCameraAttendanceState {}

class DisplayCameraAttendanceLoading extends DisplayCameraAttendanceState {}

class DisplayCameraAttendanceCheckLate extends DisplayCameraAttendanceState {
  final bool isLated;
  final bool showReason;

  const DisplayCameraAttendanceCheckLate(
    this.isLated,
    this.showReason,
  );

  @override
  List<Object?> get props => [isLated, showReason];
}

class DisplayCameraAttendanceError extends DisplayCameraAttendanceState {
  final String message;

  const DisplayCameraAttendanceError(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}

class DisplayCameraAttendanceSuccess extends DisplayCameraAttendanceState {}
