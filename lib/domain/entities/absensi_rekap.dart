import 'package:equatable/equatable.dart';

class AbsensiRekap extends Equatable {
  const AbsensiRekap({
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
