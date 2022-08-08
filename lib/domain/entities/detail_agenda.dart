import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/absensi_rekap.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';

class DetailAgenda extends Equatable {
  const DetailAgenda({
    required this.agenda,
    this.attendanceRecap,
    this.totalRequestJoin,
  });

  final Agenda agenda;
  final AbsensiRekap? attendanceRecap;
  final int? totalRequestJoin;

  @override
  List<Object?> get props => [
        agenda,
        attendanceRecap,
        totalRequestJoin,
      ];
}
