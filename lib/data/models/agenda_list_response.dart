import 'package:equatable/equatable.dart';
import 'package:siak_mobile/data/models/agenda_model.dart';

class AgendaListResponse extends Equatable {
  final List<AgendaResponse> agendaList;

  const AgendaListResponse({required this.agendaList});

  factory AgendaListResponse.fromJson(Map<String, dynamic> json) =>
      AgendaListResponse(
        agendaList: List<AgendaResponse>.from((json["all_agenda"] as List)
            .map((x) => AgendaResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all_agenda": List<dynamic>.from(agendaList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [agendaList];
}
