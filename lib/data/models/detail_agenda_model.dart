import 'package:equatable/equatable.dart';
import 'package:siak_mobile/data/models/absensi_model.dart';
import 'package:siak_mobile/data/models/absensi_rekap_response.dart';
import 'package:siak_mobile/data/models/agenda_model.dart';
import 'package:siak_mobile/domain/entities/detail_agenda.dart';

class DetailAgendaResponse extends Equatable {
  const DetailAgendaResponse({
    required this.agenda,
    this.attendanceRecap,
    this.totalRequestJoin,
    this.absensi,
  });

  final AgendaResponse agenda;
  final AbsensiRekapResponse? attendanceRecap;
  final int? totalRequestJoin;
  final AbsensiResponse? absensi;

  factory DetailAgendaResponse.fromJson(Map<String, dynamic> json) =>
      DetailAgendaResponse(
        agenda: AgendaResponse.fromJson(json["agenda"]),
        attendanceRecap: json["attendance_recap"] != null
            ? AbsensiRekapResponse.fromJson(json["attendance_recap"])
            : null,
        totalRequestJoin: json["total_request_join"],
        absensi: json["status_absensi"] != null
            ? AbsensiResponse.fromJson(
                json["status_absensi"],
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
        "agenda": agenda.toJson(),
        "attendance_recap": attendanceRecap?.toJson(),
        "total_request_join": totalRequestJoin,
        "status_absensi": absensi,
      };

  DetailAgenda toEntity() {
    return DetailAgenda(
      agenda: agenda.toEntity(),
      attendanceRecap: attendanceRecap?.toEntity(),
      totalRequestJoin: totalRequestJoin,
      absensi: absensi?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        agenda,
        attendanceRecap,
        totalRequestJoin,
        absensi,
      ];
}
