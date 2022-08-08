import 'package:equatable/equatable.dart';
import 'package:siak_mobile/data/models/agenda_model.dart';

class StudentListResponse extends Equatable {
  final List<AgendaResponse> agendaList;

  const StudentListResponse({required this.agendaList});

  factory StudentListResponse.fromJson(Map<String, dynamic> json) =>
      StudentListResponse(
        agendaList: List<AgendaResponse>.from((json["all_student"] as List)
            .map((x) => AgendaResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all_student": List<dynamic>.from(agendaList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [agendaList];
}
