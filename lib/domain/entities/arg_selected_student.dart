import 'package:equatable/equatable.dart';

class ArgSelectedStudent extends Equatable {
  final String idAgenda;
  final String? nosiswa;

  const ArgSelectedStudent({
    required this.idAgenda,
    this.nosiswa,
  });

  @override
  List<Object?> get props => [idAgenda, nosiswa];
}
