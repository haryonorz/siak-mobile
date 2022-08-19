import 'package:siak_mobile/common/exceptions.dart';
import 'package:siak_mobile/data/datasources/db/helper/database_helper.dart';
import 'package:siak_mobile/data/models/user_model.dart';

abstract class UserLocalDataSource {
  Future<String> insertUser(UserResponse user);
  Future<String> removeUser();
  Future<UserResponse?> getUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final DatabaseHelper databaseHelper;

  UserLocalDataSourceImpl({required this.databaseHelper});
  @override
  Future<String> insertUser(UserResponse user) async {
    try {
      await databaseHelper.insertUser(user);
      return 'Insert success';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeUser() async {
    try {
      await databaseHelper.removeUser();
      return 'Remove success';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<UserResponse?> getUser() async {
    final result = await databaseHelper.getUser();
    if (result != null) {
      return UserResponse.fromJson(result);
    } else {
      return null;
    }
  }
}
