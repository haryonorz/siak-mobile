import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';

class Agenda extends Equatable {
  const Agenda({
    required this.idAgenda,
    required this.pokokBahasan,
    required this.bidangStudi,
    required this.namaTutor,
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
  final String namaTutor;
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
  final List<Absensi> allStudent;
  final int? totalStudent;

  @override
  List<Object?> get props => [
        idAgenda,
        pokokBahasan,
        bidangStudi,
        namaTutor,
        namaTutorPengganti,
        pilKelas,
        center,
        ruangan,
        date,
        jamIn,
        jamOut,
        status,
        allStudent,
        totalStudent,
      ];
}
