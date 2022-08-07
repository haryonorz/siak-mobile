import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';

class Agenda extends Equatable {
  const Agenda({
    required this.idAgenda,
    required this.pokokBahasan,
    required this.bidangStudi,
    required this.tutor,
    required this.tutorPengganti,
    required this.pilKelas,
    required this.center,
    required this.ruangan,
    required this.date,
    required this.jamIn,
    required this.jamOut,
    required this.allStudent,
    required this.totalStudent,
  });

  final String idAgenda;
  final String pokokBahasan;
  final String bidangStudi;
  final String tutor;
  final String tutorPengganti;
  final String pilKelas;
  final String center;
  final String ruangan;
  final String date;
  final String jamIn;
  final String jamOut;
  final List<Absensi> allStudent;
  final int totalStudent;

  @override
  List<Object?> get props => [
        idAgenda,
        pokokBahasan,
        bidangStudi,
        tutor,
        tutorPengganti,
        pilKelas,
        center,
        ruangan,
        date,
        jamIn,
        jamOut,
      ];
}
