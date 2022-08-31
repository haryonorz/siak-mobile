import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/user.dart';

class UserResponse extends Equatable {
  const UserResponse({
    required this.username,
    required this.nama,
    required this.noHp,
    required this.foto,
    required this.type,
  });

  final String username;
  final String nama;
  final String noHp;
  final String foto;
  final String type;

  factory UserResponse.fromEntity(User user) => UserResponse(
        username: user.username,
        nama: user.nama,
        noHp: user.noHp,
        foto: user.foto,
        type: user.type,
      );

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        username: json["username"],
        nama: json["nama"],
        noHp: json["no_hp"],
        foto: json["foto"] ?? '',
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "nama": nama,
        "no_hp": noHp,
        "foto": foto,
        "type": type,
      };

  User toEntity() {
    return User(
      username: username,
      nama: nama,
      noHp: noHp,
      foto: foto,
      type: type,
    );
  }

  @override
  List<Object?> get props => [
        username,
        nama,
        noHp,
        foto,
        type,
      ];
}
