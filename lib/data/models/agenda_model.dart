import 'package:equatable/equatable.dart';
import 'package:siak_mobile/data/models/absensi_model.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';

class AgendaResponse extends Equatable {
  const AgendaResponse({
    required this.idAgenda,
    required this.pokokBahasan,
    required this.bidangStudi,
    this.tutor,
    required this.namaTutor,
    this.tutorPengganti,
    this.namaTutorPengganti,
    this.center,
    required this.namaCenter,
    required this.pilKelas,
    required this.ruangan,
    required this.date,
    required this.jamIn,
    required this.jamOut,
    this.aktivitas,
    this.aktivitasDesc,
    this.aktivitasLainnya,
    this.catatanKelas,
    required this.status,
    required this.allStudent,
    this.totalStudent,
  });

  final String idAgenda;
  final String pokokBahasan;
  final String bidangStudi;
  final String? tutor;
  final String namaTutor;
  final String? tutorPengganti;
  final String? namaTutorPengganti;
  final String? center;
  final String namaCenter;
  final String pilKelas;
  final String ruangan;
  final String date;
  final String jamIn;
  final String jamOut;
  final String? aktivitas;
  final String? aktivitasDesc;
  final String? aktivitasLainnya;
  final String? catatanKelas;
  final String status;
  final List<AbsensiResponse> allStudent;
  final int? totalStudent;

  factory AgendaResponse.fromJson(Map<String, dynamic> json) => AgendaResponse(
        idAgenda: json["id_agenda"],
        pokokBahasan: json["pokok_bahasan"],
        bidangStudi: json["bidang_studi"],
        tutor: json["tutor"],
        namaTutor: json["nama_tutor"],
        tutorPengganti: json["tutor_pengganti"],
        namaTutorPengganti: json["nama_tutor_pengganti"],
        center: json["center"],
        namaCenter: json["nama_center"],
        pilKelas: json["pil_kelas"],
        ruangan: json["ruangan"],
        date: json["date"],
        jamIn: json["jam_in"],
        jamOut: json["jam_out"],
        aktivitas: json["aktivitas"],
        aktivitasDesc: json["aktivitas_desc"],
        aktivitasLainnya: json["aktivitas_lainnya"],
        catatanKelas: json["catatan_kelas"],
        status: json["status"],
        allStudent: List<AbsensiResponse>.from((json["all_student"] as List)
            .map((x) => AbsensiResponse.fromJson(x))),
        totalStudent: json["total_student"],
      );

  Map<String, dynamic> toJson() => {
        "id_agenda": idAgenda,
        "pokok_bahasan": pokokBahasan,
        "bidang_studi": bidangStudi,
        "tutor": tutor,
        "nama_tutor": namaTutor,
        "tutor_pengganti": tutorPengganti,
        "nama_tutor_pengganti": namaTutorPengganti,
        "center": center,
        "nama_center": namaCenter,
        "pil_kelas": pilKelas,
        "ruangan": ruangan,
        "date": date,
        "jam_in": jamIn,
        "jam_out": jamOut,
        "aktivitas": aktivitas,
        "aktivitas_desc": aktivitasDesc,
        "aktivitas_lainnya": aktivitasLainnya,
        "catatan_kelas": catatanKelas,
        "status": status,
        "all_student": List<dynamic>.from(allStudent.map((x) => x)),
        "total_student": totalStudent,
      };

  Agenda toEntity() {
    return Agenda(
      idAgenda: idAgenda,
      pokokBahasan: pokokBahasan,
      bidangStudi: bidangStudi,
      namaTutor: namaTutor,
      namaTutorPengganti: namaTutorPengganti,
      pilKelas: pilKelas,
      center: center,
      namaCenter: namaCenter,
      ruangan: ruangan,
      date: date,
      jamIn: jamIn,
      jamOut: jamOut,
      aktivitas: aktivitas,
      aktivitasDesc: aktivitasDesc,
      aktivitasLainnya: aktivitasLainnya,
      catatanKelas: catatanKelas,
      status: status,
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
        aktivitas,
        aktivitasDesc,
        aktivitasLainnya,
        allStudent,
        totalStudent,
      ];
}
