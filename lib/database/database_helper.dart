import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task/model/user.dart';

class DatabaseHelper {
  static const _databaseName = 'task2.db';
  static const _databaseVersion = 1;
  Database? _database;

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
//read or create db
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

//create
  _initDatabase() async {
    Directory dataDirectory =
        await getApplicationDocumentsDirectory(); //path app in files
    String dbPath = join(dataDirectory.path, _databaseName);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

//create table
  _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE  Task (
      id INTEGER PRIMARY KEY,
       firstname TEXT,
        lastname TEXT,
         email TEXT,
         phone INTEGER,
         gender TEXT ,
         dataofbirth TEXT ,
         picture TEXT,
         password TEXT,
         address TEXT)
    ''');
  }

  Future<int> insertUser(User user) async {
    Database? db = await database;
    return await db!.insert('Task', user.toMap());
  }

  Future<int> updateUser(User user) async {
    Database? db = await database;
    return await db!
        .update('Task', user.toMap(), where: 'id=?', whereArgs: [user.id]);
  }

  Future<int> deleteUser(int id) async {
    Database? db = await database;
    return await db!.delete('Task', where: 'id=?', whereArgs: [id]);
  }

  Future<List<User>> fetchUsers() async {
    Database? db = await database;
    List<Map> users = await db!.query('Task');
    return users.length == 0 ? [] : users.map((e) => User.fromMap(e)).toList();
  }

  // Future<List<User>> fetchSearchUsers(User user) async {
  //   Database? db = await database;
  //   List<Map> users = await db!.rawQuery(
  //       "SELECT * FROM Task WHERE ${User.colName} LIKE '%${User.search.toUpperCase()}%' OR ${User.colMobile} LIKE '%${User.search.toUpperCase()}%' OR ${User.colAddress} LIKE '%${User.search.toUpperCase()}%' OR ${User.colBirthday} LIKE '%${User.search.toUpperCase()}%' OR ${User.colGender}='${User.search.toUpperCase()}'");
  //   return users.length == 0 ? [] : users.map((e) => User.fromMap(e)).toList();
  // }
}
