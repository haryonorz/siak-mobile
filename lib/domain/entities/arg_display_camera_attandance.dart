import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';

class ArgDisplayCameraAttendance extends Equatable {
  final Agenda agenda;
  final Absensi absensi;
  final bool photoReset;

  const ArgDisplayCameraAttendance({
    required this.agenda,
    required this.absensi,
    this.photoReset = false,
  });

  @override
  List<Object?> get props => [
        agenda,
        absensi,
        photoReset,
      ];
}
