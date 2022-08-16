import 'package:equatable/equatable.dart';

class Tutor extends Equatable {
  const Tutor({
    required this.kodeTutor,
    required this.nama,
    required this.noHp,
    required this.password,
    required this.foto,
    required this.kelas,
    required this.study,
  });

  final String kodeTutor;
  final String nama;
  final String noHp;
  final String password;
  final String foto;
  final String kelas;
  final String study;

  @override
  List<Object?> get props => [
        kodeTutor,
        nama,
        noHp,
        password,
        foto,
        kelas,
        study,
      ];
}
