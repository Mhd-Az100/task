import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task/model/contact.dart';
import 'package:task/model/user.dart';

class DatabaseHelper {
  static const _databaseName = 'task.db';
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
    await db.execute(''' CREATE TABLE  User (
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         firstname TEXT,
         lastname TEXT,
         email TEXT,
         phone TEXT,
         gender TEXT,
         dataofbirth TEXT,
         password TEXT
         )''');
    await db.execute(''' CREATE TABLE  Contacts (
         id INTEGER PRIMARY KEY,
         name TEXT,
         phone TEXT,
         address TEXT,
         FOREIGN KEY(userid) REFERENCES User(id)
         )''');
  }

  Future<int> insertUser(User user) async {
    Database? db = await database;
    // var res = await db!.rawInsert('''
    // INSERT INTO User(firstname ,lastname ,email , phone ,gender , dataofbirth ,picture , password ,address )
    // VALUES ($user.firstname , $user.lastname , $user.email , $user.phone , $user.gender ,$user.dataofbirth ,$user.picture , $user.password , $user.address);
    // ''');
    var res = await db!.insert('User', user.toJson());
    // Future.delayed(Duration(seconds: 3));
    // var rese = await db.rawQuery("SELECT email FROM User");
    // print(rese);
    return res;
  }

  Future<dynamic> getLastID() async {
    Database? db = await database;
    var res = await db!.rawQuery("SELECT last_insert_rowid() AS id");
    print("here the last id : $res");
    return res;
  }

  Future<int> updateUser(User user) async {
    Database? db = await database;
    return await db!
        .update('User', user.toJson(), where: 'id=?', whereArgs: [user.id]);
  }

  Future<dynamic> getLogin(String email, String password) async {
    var dbClient = await database;
    var res = await dbClient!.rawQuery(
        "SELECT id ,firstname, lastname ,email ,phone  ,gender ,dataofbirth ,password FROM User WHERE email = '$email' and password = '$password'");
    print(res);

    if (res.length > 0) {
      return new User.fromJson(res.first);
    }

    return 0;
  }

  // auth(String email, String password) async {
  //   Database? db = await database;
  //   List<Map> contacts = await db!.rawQuery(
  //       "SELECT * FROM User WHERE email =? [$email] AND password = ?$password ");
  //   return contacts.length;
  // }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<int> deleteUser(int id) async {
    Database? db = await database;
    return await db!.delete('User', where: 'id=?', whereArgs: [id]);
  }

  Future<List<User>> fetchUsers() async {
    Database? db = await database;
    List<Map> users = await db!.query('User');
    return users.length == 0 ? [] : users.map((e) => User.fromJson(e)).toList();
  }

//=================================  contact  ======================================
  Future<int> insertContact(Contact contact) async {
    Database? db = await database;
    return await db!.insert('Contacts', contact.toMap());
  }

  Future<int> updateContact(Contact contact) async {
    Database? db = await database;
    return await db!.update('Contacts', contact.toMap(),
        where: 'id=?', whereArgs: [contact.id]);
  }

  Future<int> deleteContact(int id) async {
    Database? db = await database;
    return await db!.delete('Contacts', where: 'id=?', whereArgs: [id]);
  }

  Future<List<Contact>> fetchContacts(String id) async {
    Database? db = await database;
    List<Map> contacts = await db!
        .rawQuery('SELECT * FROM Contacts WHERE Contacts.userid = $id ');
    return contacts.length == 0
        ? []
        : contacts.map((e) => Contact.fromMap(e)).toList();
  }

  //------------------shared preferences----------------------------------------
  savepref(
    String? firstName,
    String? lastName,
    String? email,
    int? id,
    String? picture,
    String? phone,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('firstname', firstName!);
    preferences.setString('lastname', lastName!);
    preferences.setString('email', email!);
    preferences.setString('id', id.toString());
    preferences.setString('picture', picture.toString());
    preferences.setString('phone', phone.toString());
  }
}
