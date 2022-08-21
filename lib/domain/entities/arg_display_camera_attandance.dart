import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';

class ArgDisplayCameraAttendance extends Equatable {
  final Absensi absensi;
  final bool photoReset;

  const ArgDisplayCameraAttendance({
    required this.absensi,
    this.photoReset = false,
  });

  @override
  List<Object?> get props => [absensi];
}
