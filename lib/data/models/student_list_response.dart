import 'package:equatable/equatable.dart';
import 'package:siak_mobile/data/models/absensi_model.dart';

class StudentListResponse extends Equatable {
  final List<AbsensiResponse> studentList;

  const StudentListResponse({required this.studentList});

  factory StudentListResponse.fromJson(Map<String, dynamic> json) =>
      StudentListResponse(
        studentList: List<AbsensiResponse>.from((json["all_student"] as List)
            .map((x) => AbsensiResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all_student": List<dynamic>.from(studentList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [studentList];
}
