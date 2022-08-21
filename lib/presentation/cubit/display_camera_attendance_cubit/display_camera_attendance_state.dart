part of 'display_camera_attendance_cubit.dart';

abstract class DisplayCameraAttendanceState extends Equatable {
  const DisplayCameraAttendanceState();

  @override
  List<Object?> get props => [];
}

class DisplayCameraAttendanceInitial extends DisplayCameraAttendanceState {}

class DisplayCameraAttendanceLoading extends DisplayCameraAttendanceState {}

class DisplayCameraAttendanceError extends DisplayCameraAttendanceState {
  final String message;

  const DisplayCameraAttendanceError(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}

class DisplayCameraAttendanceSuccess extends DisplayCameraAttendanceState {}
