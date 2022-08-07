import 'package:equatable/equatable.dart';

class Absensi extends Equatable {
  const Absensi({
    required this.idAgenda,
    required this.noSiswa,
    required this.namaSiswa,
    required this.pilKelas,
    this.tgl,
    this.jam,
    this.fotoAbsen,
    this.masalahSiswa,
    required this.statusSiswa,
    this.verification,
    required this.statusAbsensi,
    this.alasanTerlambat,
  });

  final String idAgenda;
  final String noSiswa;
  final String namaSiswa;
  final String pilKelas;
  final String? tgl;
  final String? jam;
  final String? fotoAbsen;
  final String? masalahSiswa;
  final String statusSiswa;
  final String? verification;
  final String statusAbsensi;
  final String? alasanTerlambat;

  @override
  List<Object?> get props => [
        idAgenda,
        noSiswa,
        namaSiswa,
        pilKelas,
        tgl,
        jam,
        fotoAbsen,
        masalahSiswa,
        statusSiswa,
        verification,
        statusAbsensi,
        alasanTerlambat,
      ];
}
