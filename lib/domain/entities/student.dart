import 'package:equatable/equatable.dart';

class Student extends Equatable {
  const Student({
    required this.noSiswa,
    required this.kelas,
    required this.thnAjar,
    required this.nama,
    required this.pilKelas,
    required this.noHp,
    required this.noHpOrangtua,
    required this.foto,
    required this.center,
    required this.type,
  });

  final String noSiswa;
  final String kelas;
  final String thnAjar;
  final String nama;
  final String pilKelas;
  final String noHp;
  final String noHpOrangtua;
  final String foto;
  final String center;
  final String type;

  @override
  List<Object?> get props => [
        noSiswa,
        kelas,
        thnAjar,
        nama,
        pilKelas,
        noHp,
        noHpOrangtua,
        foto,
        center,
        type,
      ];
}
