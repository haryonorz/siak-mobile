import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';

class ArgAttendanceList extends Equatable {
  final String idAgenda;
  final Absensi? absensi;

  const ArgAttendanceList({
    required this.idAgenda,
    this.absensi,
  });

  @override
  List<Object?> get props => [idAgenda, absensi];
}
