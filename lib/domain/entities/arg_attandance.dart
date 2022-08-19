import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';

class ArgCameraAttendance extends Equatable {
  final Absensi absensi;
  final String userType;

  const ArgCameraAttendance({
    required this.absensi,
    required this.userType,
  });

  @override
  List<Object?> get props => [absensi, userType];
}
