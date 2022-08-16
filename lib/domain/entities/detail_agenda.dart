import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/absensi_rekap.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';

class DetailAgenda extends Equatable {
  const DetailAgenda({
    required this.agenda,
    this.attendanceRecap,
    this.totalRequestJoin,
    this.absensi,
  });

  final Agenda agenda;
  final AbsensiRekap? attendanceRecap;
  final int? totalRequestJoin;
  final Absensi? absensi;

  @override
  List<Object?> get props => [
        agenda,
        attendanceRecap,
        totalRequestJoin,
        absensi,
      ];
}
