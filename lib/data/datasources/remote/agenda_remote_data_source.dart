import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:siak_mobile/common/exceptions.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/data/models/absensi_model.dart';
import 'package:siak_mobile/data/models/agenda_list_response.dart';
import 'package:siak_mobile/data/models/agenda_model.dart';
import 'package:siak_mobile/data/models/detail_agenda_model.dart';
import 'package:siak_mobile/data/models/error_response.dart';
import 'package:siak_mobile/data/models/info_activity_class_response.dart';
import 'package:siak_mobile/data/models/info_problem_class_response.dart';
import 'package:siak_mobile/data/models/student_list_response.dart';

abstract class AgendaRemoteDataSources {
  Future<List<AgendaResponse>> getAllAgenda(
    String username,
    String userType,
    String getType,
    int page, {
    String keyword = '',
  });
  Future<List<AgendaResponse>> getAllAgendaHistory(
    String username,
    String userType,
    String getType,
    int page, {
    String keyword = '',
  });
  Future<DetailAgendaResponse> getDetailAgenda(
    String idAgenda,
    String username,
    String userType,
  );
  Future<List<AbsensiResponse>> getAllRequestJoin(String idAgenda);
  Future<List<AbsensiResponse>> getAllStudent(String idAgenda);
  Future<List<AbsensiResponse>> getAllGuestStudent(String idAgenda);
  Future<List<AbsensiResponse>> getAllSituationClass(String idAgenda);
  Future<InfoActivityClassResponse> getInfoActivityClass();
  Future<InfoProblemClassResponse> getInfoProblemClass();
  Future<List<AbsensiResponse>> getStudentInClass(
    String idAgenda,
    String getType, {
    String keyword = '',
  });

  Future<bool> doAttendance(
    String idAgenda,
    String userType,
    File photo,
    String noStudent,
    String date,
    String time,
    String latitude,
    String longitude,
    String late,
    String lateReason,
  );

  Future<bool> doPhotoResetTutor(
    String idAgenda,
    String userType,
    File photo,
    String noStudent,
    String date,
    String time,
  );
  Future<bool> doVerificationAttends(
    String idAgenda,
    String noStudent,
    String statusAttends,
  );
  Future<bool> doAddDailyActivity(
    String idAgenda,
    String idActivity,
    String activityText,
    String otherActivity,
  );
  Future<bool> doAcceptRequestJoin(String idAgenda, String noStudent);
  Future<bool> doAddSituationClass(
    String idAgenda,
    String noStudent,
    String idProblem,
    String problemStudent,
  );
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
    int page, {
    String keyword = '',
  }) async {
    final response = await client.post(
      Uri.parse(EndPoints.getAllAgenda),
      body: {
        'key': EndPoints.key,
        'username': username,
        'user_type': userType,
        'get_type': getType,
        'keyword': keyword,
        'page': page.toString(),
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
    int page, {
    String keyword = '',
  }) async {
    final response = await client.post(
      Uri.parse(EndPoints.getAllAgendaHistory),
      body: {
        'key': EndPoints.key,
        'username': username,
        'user_type': userType,
        'get_type': getType,
        'keyword': keyword,
        'page': page.toString(),
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
    String username,
    String userType,
  ) async {
    final response = await client.post(
      Uri.parse(EndPoints.getDetailAgenda),
      body: {
        'key': EndPoints.key,
        'id_agenda': idAgenda,
        'username': username,
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
  Future<InfoActivityClassResponse> getInfoActivityClass() async {
    final response = await client.post(
      Uri.parse(EndPoints.getInfoActivityClass),
      body: {
        'key': EndPoints.key,
      },
    );
    if (response.statusCode == 200) {
      return InfoActivityClassResponse.fromJson(json.decode(response.body));
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }

  @override
  Future<InfoProblemClassResponse> getInfoProblemClass() async {
    final response = await client.post(
      Uri.parse(EndPoints.getInfoProblemClass),
      body: {
        'key': EndPoints.key,
      },
    );
    if (response.statusCode == 200) {
      return InfoProblemClassResponse.fromJson(json.decode(response.body));
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }

  @override
  Future<List<AbsensiResponse>> getStudentInClass(
    String idAgenda,
    String getType, {
    String keyword = '',
  }) async {
    final response = await client.post(
      Uri.parse(EndPoints.getStudentInClass),
      body: {
        'key': EndPoints.key,
        'id_agenda': idAgenda,
        'get_type': getType,
        'keyword': keyword,
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
  Future<bool> doAttendance(
    String idAgenda,
    String userType,
    File photo,
    String noStudent,
    String date,
    String time,
    String latitude,
    String longitude,
    String late,
    String lateReason,
  ) async {
    var request =
        http.MultipartRequest("POST", Uri.parse(EndPoints.doAttendance));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(
      http.MultipartFile(
        'photo',
        photo.readAsBytes().asStream(),
        photo.lengthSync(),
        filename: basename(photo.path),
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      'key': EndPoints.key,
      'id_agenda': idAgenda,
      'user_type': userType,
      'no_siswa': noStudent,
      'tgl': date,
      'jam': time,
      'latitude': latitude,
      'longitude': longitude,
      'terlambat': late,
      'alasan_terlambat': lateReason,
    });
    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      var responseError = await http.Response.fromStream(response);
      final error = ErrorResponse.fromJson(json.decode(responseError.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }

  @override
  Future<bool> doPhotoResetTutor(
    String idAgenda,
    String userType,
    File photo,
    String noStudent,
    String date,
    String time,
  ) async {
    var request =
        http.MultipartRequest("POST", Uri.parse(EndPoints.doPhotoResetTutor));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(
      http.MultipartFile(
        'photo',
        photo.readAsBytes().asStream(),
        photo.lengthSync(),
        filename: basename(photo.path),
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      'key': EndPoints.key,
      'id_agenda': idAgenda,
      'user_type': userType,
      'no_siswa': noStudent,
      'tgl': date,
      'jam': time,
    });
    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      var responseError = await http.Response.fromStream(response);
      final error = ErrorResponse.fromJson(json.decode(responseError.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }

  @override
  Future<bool> doVerificationAttends(
    String idAgenda,
    String noStudent,
    String statusAttends,
  ) async {
    final response = await client.post(
      Uri.parse(EndPoints.doVerificationAttends),
      body: {
        'key': EndPoints.key,
        'id_agenda': idAgenda,
        'no_siswa': noStudent,
        'status_absensi': statusAttends,
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
  Future<bool> doAddDailyActivity(
    String idAgenda,
    String idActivity,
    String activityText,
    String otherActivity,
  ) async {
    final response = await client.post(
      Uri.parse(EndPoints.doAddDailyActivity),
      body: {
        'key': EndPoints.key,
        'id_agenda': idAgenda,
        'aktivitas': idActivity,
        'aktivitas_desc': activityText,
        'aktivitas_lainnya': otherActivity,
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
  Future<bool> doAddSituationClass(
    String idAgenda,
    String noStudent,
    String idProblem,
    String problemStudent,
  ) async {
    final response = await client.post(
      Uri.parse(EndPoints.doAddSituationClass),
      body: {
        'key': EndPoints.key,
        'id_agenda': idAgenda,
        'no_siswa': noStudent,
        'id_problem': idProblem,
        'masalah_siswa': problemStudent,
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
