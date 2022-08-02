import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siak_mobile/common/exceptions.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/data/models/error_response.dart';
import 'package:siak_mobile/data/models/user_model.dart';

abstract class UserRemoteDataSources {
  Future<UserResponse> doSignIn(String username, String password);
  Future<bool> doSignOut(String username, String type);
}

class UserRemoteDataSourcesImpl extends UserRemoteDataSources {
  final http.Client client;

  UserRemoteDataSourcesImpl({required this.client});

  @override
  Future<UserResponse> doSignIn(String username, String password) async {
    final response = await client.post(
      Uri.parse(EndPoints.signIn),
      body: {
        'key': EndPoints.key,
        'username': username,
        'password': password,
        'token': 'test',
      },
    );
    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body));
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw ServerException(
          'Server Error [${response.statusCode}]: ${error.message}');
    }
  }

  @override
  Future<bool> doSignOut(String username, String type) async {
    final response = await client.post(
      Uri.parse(EndPoints.signOut),
      body: {
        'key': EndPoints.key,
        'username': username,
        'type': type,
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
