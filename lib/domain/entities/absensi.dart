import 'package:equatable/equatable.dart';

class Absensi extends Equatable {
  const Absensi({
    required this.idAgenda,
    required this.noSiswa,
    required this.namaSiswa,
    required this.foto,
    required this.pilKelas,
    this.tgl,
    this.jam,
    this.fotoAbsen,
    this.masalahSiswa,
    required this.statusSiswa,
    this.verification,
    required this.statusAbsensi,
    required this.terlambat,
    this.alasanTerlambat,
  });

  final String idAgenda;
  final String noSiswa;
  final String namaSiswa;
  final String foto;
  final String pilKelas;
  final String? tgl;
  final String? jam;
  final String? fotoAbsen;
  final String? masalahSiswa;
  final String statusSiswa;
  final String? verification;
  final String statusAbsensi;
  final String terlambat;
  final String? alasanTerlambat;

  @override
  List<Object?> get props => [
        idAgenda,
        noSiswa,
        namaSiswa,
        foto,
        pilKelas,
        tgl,
        jam,
        fotoAbsen,
        masalahSiswa,
        statusSiswa,
        verification,
        statusAbsensi,
        terlambat,
        alasanTerlambat,
      ];
}
