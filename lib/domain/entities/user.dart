import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
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

  @override
  List<Object?> get props => [
        username,
        nama,
        noHp,
        foto,
        type,
      ];
}
