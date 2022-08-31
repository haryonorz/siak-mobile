import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';

class ArgCameraAttendance extends Equatable {
  final Agenda agenda;
  final Absensi absensi;
  final String userType;
  final bool photoReset;

  const ArgCameraAttendance({
    required this.agenda,
    required this.absensi,
    required this.userType,
    this.photoReset = false,
  });

  @override
  List<Object?> get props => [absensi, userType, photoReset];
}
