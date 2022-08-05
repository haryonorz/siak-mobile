import 'package:equatable/equatable.dart';
import 'package:siak_mobile/data/models/absensi_model.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';

class AgendaResponse extends Equatable {
  const AgendaResponse({
    required this.idAgenda,
    required this.pokokBahasan,
    required this.bidangStudi,
    required this.tutor,
    required this.tutorPengganti,
    required this.pilKelas,
    required this.center,
    required this.ruangan,
    required this.date,
    required this.jamIn,
    required this.jamOut,
    required this.allStudent,
    required this.totalStudent,
  });

  final String idAgenda;
  final String pokokBahasan;
  final String bidangStudi;
  final String tutor;
  final String tutorPengganti;
  final String pilKelas;
  final String center;
  final String ruangan;
  final String date;
  final String jamIn;
  final String jamOut;
  final List<AbsensiResponse> allStudent;
  final int totalStudent;

  factory AgendaResponse.fromJson(Map<String, dynamic> json) => AgendaResponse(
        idAgenda: json["id_agenda"],
        pokokBahasan: json["pokok_bahasan"],
        bidangStudi: json["bidang_studi"],
        tutor: json["tutor"],
        tutorPengganti: json["tutor_pengganti"],
        pilKelas: json["pil_kelas"],
        center: json["center"],
        ruangan: json["ruangan"],
        date: json["date"],
        jamIn: json["jam_in"],
        jamOut: json["jam_out"],
        allStudent: List<AbsensiResponse>.from((json["all_student"] as List)
            .map((x) => AbsensiResponse.fromJson(x))),
        totalStudent: json["total_student"],
      );

  Map<String, dynamic> toJson() => {
        "id_agenda": idAgenda,
        "pokok_bahasan": pokokBahasan,
        "bidang_studi": bidangStudi,
        "tutor": tutor,
        "tutor_pengganti": tutorPengganti,
        "pil_kelas": pilKelas,
        "center": center,
        "ruangan": ruangan,
        "date": date,
        "jam_in": jamIn,
        "jam_out": jamOut,
        "all_student": List<dynamic>.from(allStudent.map((x) => x)),
        "total_student": totalStudent,
      };

  Agenda toEntity() {
    return Agenda(
      idAgenda: idAgenda,
      pokokBahasan: pokokBahasan,
      bidangStudi: bidangStudi,
      tutor: tutor,
      tutorPengganti: tutorPengganti,
      pilKelas: pilKelas,
      center: center,
      ruangan: ruangan,
      date: date,
      jamIn: jamIn,
      jamOut: jamOut,
      allStudent: allStudent.map((absensi) => absensi.toEntity()).toList(),
      totalStudent: totalStudent,
    );
  }

  @override
  List<Object?> get props => [
        idAgenda,
        pokokBahasan,
        bidangStudi,
        tutor,
        tutorPengganti,
        pilKelas,
        center,
        ruangan,
        date,
        jamIn,
        jamOut,
      ];
}
