import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siak_mobile/common/exceptions.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/data/models/absensi_model.dart';
import 'package:siak_mobile/data/models/agenda_list_response.dart';
import 'package:siak_mobile/data/models/agenda_model.dart';
import 'package:siak_mobile/data/models/detail_agenda_model.dart';
import 'package:siak_mobile/data/models/error_response.dart';
import 'package:siak_mobile/data/models/student_list_response.dart';

abstract class AgendaRemoteDataSources {
  Future<List<AgendaResponse>> getAllAgenda(
    String username,
    String userType,
    String getType,
  );
  Future<List<AgendaResponse>> getAllAgendaHistory(
    String username,
    String userType,
    String getType,
  );
  Future<DetailAgendaResponse> getDetailAgenda(
    String idAgenda,
    String userType,
  );
  Future<List<AbsensiResponse>> getAllRequestJoin(String idAgenda);
  Future<List<AbsensiResponse>> getAllStudent(String idAgenda);
  Future<List<AbsensiResponse>> getAllGuestStudent(String idAgenda);
  Future<List<AbsensiResponse>> getAllSituationClass(String idAgenda);

  Future<bool> doAcceptRequestJoin(String idAgenda, String noStudent);
  Future<bool> doUpdateNoteClass(String idAgenda, String note);
  Future<bool> doCloseAgenda(String idAgenda);
}

class AgendaRemoteDataSourcesImpl extends AgendaRemoteDataSources {
  final http.Client client;

  AgendaRemoteDataSourcesImpl({required this.client});

  @override
  Future<List<AgendaResponse>> getAllAgenda(
    String username,
    String userType,
    String getType,
  ) async {
    final response = await client.post(
      Uri.parse(EndPoints.getAllAgenda),
      body: {
        'key': EndPoints.key,
        'username': username,
        'user_type': userType,
        'get_type': getType,
        'page': "0",
      },
    );
    if (response.statusCode == 200) {
      return AgendaListResponse.fromJson(json.decode(response.body)).agendaList;
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }

  @override
  Future<List<AgendaResponse>> getAllAgendaHistory(
    String username,
    String userType,
    String getType,
  ) async {
    final response = await client.post(
      Uri.parse(EndPoints.getAllAgendaHistory),
      body: {
        'key': EndPoints.key,
        'username': username,
        'user_type': userType,
        'get_type': getType,
        'page': "0",
      },
    );
    if (response.statusCode == 200) {
      return AgendaListResponse.fromJson(json.decode(response.body)).agendaList;
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }

  @override
  Future<DetailAgendaResponse> getDetailAgenda(
    String idAgenda,
    String userType,
  ) async {
    final response = await client.post(
      Uri.parse(EndPoints.getDetailAgenda),
      body: {
        'key': EndPoints.key,
        'id_agenda': idAgenda,
        'user_type': userType,
      },
    );
    if (response.statusCode == 200) {
      return DetailAgendaResponse.fromJson(json.decode(response.body));
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }

  @override
  Future<List<AbsensiResponse>> getAllRequestJoin(String idAgenda) async {
    final response = await client.post(
      Uri.parse(EndPoints.getAllRequestJoin),
      body: {
        'key': EndPoints.key,
        'id_agenda': idAgenda,
      },
    );
    if (response.statusCode == 200) {
      return StudentListResponse.fromJson(json.decode(response.body))
          .studentList;
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }

  @override
  Future<List<AbsensiResponse>> getAllStudent(String idAgenda) async {
    final response = await client.post(
      Uri.parse(EndPoints.getAllStudent),
      body: {
        'key': EndPoints.key,
        'id_agenda': idAgenda,
      },
    );
    if (response.statusCode == 200) {
      return StudentListResponse.fromJson(json.decode(response.body))
          .studentList;
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }

  @override
  Future<List<AbsensiResponse>> getAllGuestStudent(String idAgenda) async {
    final response = await client.post(
      Uri.parse(EndPoints.getAllGuestStudent),
      body: {
        'key': EndPoints.key,
        'id_agenda': idAgenda,
      },
    );
    if (response.statusCode == 200) {
      return StudentListResponse.fromJson(json.decode(response.body))
          .studentList;
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }

  @override
  Future<List<AbsensiResponse>> getAllSituationClass(String idAgenda) async {
    final response = await client.post(
      Uri.parse(EndPoints.getAllSituationClass),
      body: {
        'key': EndPoints.key,
        'id_agenda': idAgenda,
      },
    );
    if (response.statusCode == 200) {
      return StudentListResponse.fromJson(json.decode(response.body))
          .studentList;
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }

  @override
  Future<bool> doAcceptRequestJoin(String idAgenda, String noStudent) async {
    final response = await client.post(
      Uri.parse(EndPoints.doAcceptRequestJoin),
      body: {
        'key': EndPoints.key,
        'id_agenda': idAgenda,
        'no_siswa': noStudent,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }

  @override
  Future<bool> doUpdateNoteClass(String idAgenda, String note) async {
    final response = await client.post(
      Uri.parse(EndPoints.doUpdateNoteClass),
      body: {
        'key': EndPoints.key,
        'id_agenda': idAgenda,
        'catatan_kelas': note,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }

  @override
  Future<bool> doCloseAgenda(String idAgenda) async {
    final response = await client.post(
      Uri.parse(EndPoints.doCloseAgenda),
      body: {
        'key': EndPoints.key,
        'id_agenda': idAgenda,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }
}
