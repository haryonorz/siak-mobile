import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/student.dart';
import 'package:siak_mobile/domain/entities/tutor.dart';

class Profile extends Equatable {
  final Tutor? tutor;
  final Student? student;

  const Profile({
    required this.tutor,
    required this.student,
  });

  @override
  List<Object?> get props => [tutor, student];
}
