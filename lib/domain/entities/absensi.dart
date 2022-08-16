import 'package:equatable/equatable.dart';

class Absensi extends Equatable {
  const Absensi({
    required this.idAgenda,
    required this.noSiswa,
    required this.namaSiswa,
    this.foto,
    required this.pilKelas,
    this.tgl,
    this.jam,
    this.fotoAbsen,
    this.fotoAbsenTutor,
    this.idProblem,
    this.masalahSiswa,
    required this.statusSiswa,
    this.verification,
    required this.statusAbsensi,
    required this.terlambat,
    this.alasanTerlambat,
    this.selected = false,
  });

  final String idAgenda;
  final String noSiswa;
  final String namaSiswa;
  final String? foto;
  final String pilKelas;
  final String? tgl;
  final String? jam;
  final String? fotoAbsen;
  final String? fotoAbsenTutor;
  final String? idProblem;
  final String? masalahSiswa;
  final String statusSiswa;
  final String? verification;
  final String statusAbsensi;
  final String terlambat;
  final String? alasanTerlambat;
  final bool selected;

  Absensi copyWith({bool? selected}) {
    return Absensi(
      idAgenda: idAgenda,
      noSiswa: noSiswa,
      namaSiswa: namaSiswa,
      foto: foto,
      pilKelas: pilKelas,
      statusSiswa: statusSiswa,
      statusAbsensi: statusAbsensi,
      terlambat: terlambat,
      idProblem: idProblem,
      masalahSiswa: masalahSiswa,
      selected: selected ?? this.selected,
    );
  }

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
        fotoAbsenTutor,
        idProblem,
        masalahSiswa,
        statusSiswa,
        verification,
        statusAbsensi,
        terlambat,
        alasanTerlambat,
        selected,
      ];
}
