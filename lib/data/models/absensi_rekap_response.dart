import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/absensi_rekap.dart';

class AbsensiRekapResponse extends Equatable {
  const AbsensiRekapResponse({
    required this.totalSiswaKelas,
    required this.totalSiswaTamu,
    required this.totalSiswaBelumAbsensi,
    required this.totalSiswaMenungguVerifikasi,
    required this.totalSiswaHadir,
    required this.totalSiswaTidakHadir,
  });

  final int totalSiswaKelas;
  final int totalSiswaTamu;
  final int totalSiswaBelumAbsensi;
  final int totalSiswaMenungguVerifikasi;
  final int totalSiswaHadir;
  final int totalSiswaTidakHadir;

  factory AbsensiRekapResponse.fromJson(Map<String, dynamic> json) =>
      AbsensiRekapResponse(
        totalSiswaKelas: json["total_siswa_kelas"],
        totalSiswaTamu: json["total_siswa_tamu"],
        totalSiswaBelumAbsensi: json["total_siswa_belum_absensi"],
        totalSiswaMenungguVerifikasi: json["total_siswa_menunggu_verifikasi"],
        totalSiswaHadir: json["total_siswa_hadir"],
        totalSiswaTidakHadir: json["total_siswa_tidak_hadir"],
      );

  Map<String, dynamic> toJson() => {
        "total_siswa_kelas": totalSiswaKelas,
        "total_siswa_tamu": totalSiswaTamu,
        "total_siswa_belum_absensi": totalSiswaBelumAbsensi,
        "total_siswa_menunggu_verifikasi": totalSiswaMenungguVerifikasi,
        "total_siswa_hadir": totalSiswaHadir,
        "total_siswa_tidak_hadir": totalSiswaTidakHadir,
      };

  AbsensiRekap toEntity() {
    return AbsensiRekap(
      totalSiswaKelas: totalSiswaKelas,
      totalSiswaTamu: totalSiswaTamu,
      totalSiswaBelumAbsensi: totalSiswaBelumAbsensi,
      totalSiswaMenungguVerifikasi: totalSiswaMenungguVerifikasi,
      totalSiswaHadir: totalSiswaHadir,
      totalSiswaTidakHadir: totalSiswaTidakHadir,
    );
  }

  @override
  List<Object?> get props => [
        totalSiswaKelas,
        totalSiswaTamu,
        totalSiswaBelumAbsensi,
        totalSiswaMenungguVerifikasi,
        totalSiswaHadir,
        totalSiswaTidakHadir,
      ];
}
