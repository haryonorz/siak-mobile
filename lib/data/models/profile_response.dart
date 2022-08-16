import 'package:equatable/equatable.dart';
import 'package:siak_mobile/data/models/student_model.dart';
import 'package:siak_mobile/data/models/tutor_model.dart';
import 'package:siak_mobile/domain/entities/profile.dart';

class ProfileResponse extends Equatable {
  final TutorResponse? tutor;
  final StudentResponse? student;

  const ProfileResponse({
    required this.tutor,
    required this.student,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        tutor: TutorResponse.fromJson(json["tutor"]),
        student: StudentResponse.fromJson(json["student"]),
      );

  Map<String, dynamic> toJson() => {
        "tutor": tutor,
        "student": student,
      };

  Profile toEntity() => Profile(
        tutor: tutor?.toEntity(),
        student: student?.toEntity(),
      );

  @override
  List<Object?> get props => [tutor, student];
}
