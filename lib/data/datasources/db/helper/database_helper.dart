import 'dart:async';

import 'package:siak_mobile/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblUser = 'user';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/siak-mobile.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblUser (
        username TEXT PRIMARY KEY,
        nama TEXT,
        no_hp TEXT,
        foto TEXT,
        type TEXT
      );
    ''');
  }

  Future<int> insertUser(UserResponse user) async {
    final db = await database;
    return await db!.insert(_tblUser, user.toJson());
  }

  Future<int> removeUser() async {
    final db = await database;
    return await db!.delete(_tblUser);
  }

  Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    final results = await db!.query(_tblUser);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }
}
