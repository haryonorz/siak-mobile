import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/tutor.dart';

class TutorResponse extends Equatable {
  const TutorResponse({
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

  factory TutorResponse.fromJson(Map<String, dynamic> json) => TutorResponse(
        kodeTutor: json["kode_tutor"],
        nama: json["nama"],
        noHp: json["no_hp"],
        password: json["password"],
        foto: json["foto"],
        kelas: json["kelas"],
        study: json["study"],
      );

  Map<String, dynamic> toJson() => {
        "kode_tutor": kodeTutor,
        "nama": nama,
        "no_hp": noHp,
        "password": password,
        "foto": foto,
        "kelas": kelas,
        "study": study,
      };

  Tutor toEntity() {
    return Tutor(
      kodeTutor: kodeTutor,
      nama: nama,
      noHp: noHp,
      password: password,
      foto: foto,
      kelas: kelas,
      study: study,
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
