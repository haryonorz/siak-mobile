class EndPoints {
  static const String protocol = 'http';
  static const String host = '192.168.30.145';

  static const String baseUrl =
      '$protocol://$host/agenda_belajar/index.php/api_v2';
  static const String baseUrlPhoto = '$protocol://$host/agenda_belajar/upload';
  static const String key = '654321';

  static const String signIn = '$baseUrl/doLogin';
  static const String signOut = '$baseUrl/doLogout';
  static const String getProfile = '$baseUrl/getProfile';
  static const String doChangePassword = '$baseUrl/doChangePassword';

  static const String getAllAgenda = '$baseUrl/getAllAgenda';
  static const String getAllAgendaHistory = '$baseUrl/getAllAgendaHistory';
  static const String getDetailAgenda = '$baseUrl/getDetailAgenda';
  static const String getAllRequestJoin = '$baseUrl/getAllRequestJoin';
  static const String getAllStudent = '$baseUrl/getAllStudent';
  static const String getAllGuestStudent = '$baseUrl/getAllGuestStudent';
  static const String getAllSituationClass = '$baseUrl/getAllSituationClass';
  static const String getInfoActivityClass = '$baseUrl/getInfoActivityClass';
  static const String getInfoProblemClass = '$baseUrl/getInfoProblemClass';
  static const String getStudentInClass = '$baseUrl/getStudentInClass';

  static const String doAttendance = '$baseUrl/doAttendance';
  static const String doVerificationAttends = '$baseUrl/doVerificationAttends';
  static const String doAddDailyActivity = '$baseUrl/doAddDailyActivity';
  static const String doAcceptRequestJoin = '$baseUrl/doAcceptRequestJoin';
  static const String doUpdateNoteClass = '$baseUrl/doUpdateNoteClass';
  static const String doAddSituationClass = '$baseUrl/doAddSituationClass';
  static const String doCloseAgenda = '$baseUrl/doCloseAgenda';
}
