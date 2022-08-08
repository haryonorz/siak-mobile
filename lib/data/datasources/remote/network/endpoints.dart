class EndPoints {
  static const String protocol = 'http';
  static const String host = '192.168.1.6';

  static const String baseUrl =
      '$protocol://$host/agenda_belajar/index.php/api_v2';
  static const String baseUrlPhoto = '$protocol://$host/agenda_belajar/upload';
  static const String key = '654321';

  static const String signIn = '$baseUrl/doLogin';
  static const String signOut = '$baseUrl/doLogout';

  static const String getAllAgenda = '$baseUrl/getAllAgenda';
}
