import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/user.dart';

class UserResponse extends Equatable {
  const UserResponse({
    required this.noSiswa,
    required this.kelas,
    required this.thnAjar,
    required this.nama,
    required this.pilKelas,
    required this.noHp,
    required this.noHpOrangtua,
    required this.foto,
    required this.status,
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
  final String status;
  final String center;
  final String type;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        noSiswa: json["no_siswa"],
        kelas: json["kelas"],
        thnAjar: json["thn_ajar"],
        nama: json["nama"],
        pilKelas: json["pil_kelas"],
        noHp: json["no_hp"],
        noHpOrangtua: json["no_hp_orangtua"],
        foto: json["foto"],
        status: json["status"],
        center: json["center"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "no_siswa": noSiswa,
        "kelas": kelas,
        "thn_ajar": thnAjar,
        "nama": nama,
        "pil_kelas": pilKelas,
        "no_hp": noHp,
        "no_hp_orangtua": noHpOrangtua,
        "foto": foto,
        "status": status,
        "center": center,
        "type": type,
      };

  User toEntity() {
    return User(
      noSiswa: noSiswa,
      kelas: kelas,
      thnAjar: thnAjar,
      nama: nama,
      pilKelas: pilKelas,
      noHp: noHp,
      noHpOrangtua: noHpOrangtua,
      foto: foto,
      status: status,
      center: center,
      type: type,
    );
  }

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
        status,
        center,
        type,
      ];
}
