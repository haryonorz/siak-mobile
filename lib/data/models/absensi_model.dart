import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';

class AbsensiResponse extends Equatable {
  const AbsensiResponse({
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

  factory AbsensiResponse.fromJson(Map<String, dynamic> json) =>
      AbsensiResponse(
        idAgenda: json["id_agenda"],
        noSiswa: json["no_siswa"],
        namaSiswa: json["nama_siswa"],
        foto: json["foto"],
        pilKelas: json["pil_kelas"],
        tgl: json["tgl"],
        jam: json["jam"],
        fotoAbsen: json["foto_absen"],
        masalahSiswa: json["masalah_siswa"],
        statusSiswa: json["status_siswa"],
        verification: json["verification"],
        statusAbsensi: json["status_absensi"],
        terlambat: json["terlambat"],
        alasanTerlambat: json["alasan_terlambat"],
      );

  Map<String, dynamic> toJson() => {
        "id_agenda": idAgenda,
        "no_siswa": noSiswa,
        "nama_siswa": namaSiswa,
        "foto": foto,
        "pil_kelas": pilKelas,
        "tgl": tgl,
        "jam": jam,
        "foto_absen": fotoAbsen,
        "masalah_siswa": masalahSiswa,
        "status_siswa": statusSiswa,
        "verification": verification,
        "status_absensi": statusAbsensi,
        "alasan_terlambat": alasanTerlambat,
      };

  Absensi toEntity() {
    return Absensi(
      idAgenda: idAgenda,
      noSiswa: noSiswa,
      namaSiswa: namaSiswa,
      foto: foto,
      pilKelas: pilKelas,
      tgl: tgl,
      jam: jam,
      fotoAbsen: fotoAbsen,
      masalahSiswa: masalahSiswa,
      statusSiswa: statusSiswa,
      verification: verification,
      statusAbsensi: statusAbsensi,
      terlambat: terlambat,
      alasanTerlambat: alasanTerlambat,
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
        masalahSiswa,
        statusSiswa,
        verification,
        statusAbsensi,
        terlambat,
        alasanTerlambat,
      ];
}
