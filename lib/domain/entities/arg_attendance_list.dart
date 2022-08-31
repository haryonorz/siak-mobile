import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';

class ArgAttendanceList extends Equatable {
  final Agenda agenda;
  final Absensi? absensi;

  const ArgAttendanceList({
    required this.agenda,
    this.absensi,
  });

  @override
  List<Object?> get props => [agenda, absensi];
}
