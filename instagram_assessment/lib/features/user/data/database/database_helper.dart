import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';
import 'package:instagram_assessment/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static const int _version = 1;
  static const String _dbName = "Users.db";

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(
      documentsDirectory,
      _dbName,
    );
    return await openDatabase(
      path,
      version: _version,
      onCreate: (db, version) async => await db.execute(
          "CREATE TABLE User(uid TEXT PRIMARY KEY, name TEXT NOT NULL, image TEXT, email TEXT);"),
    );
  }

  // static Future<Database> _getDB() async {
  //   return openDatabase(join(await getDatabasesPath(), _dbName),
  //       onCreate: (db, version) async => await db.execute(
  //           "CREATE TABLE User(uid TEXT PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL);"),
  //       version: _version);
  // }

  static Future<int> addUser(UserModel user) async {
    final db = await instance.database;
    return await db.insert("User", user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateUser(UserModel user) async {
    return await _database!.update("User", user.toJson(),
        where: '${FirebaseFieldName.userId} = ?',
        whereArgs: [user.uid],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteUser(UserModel user) async {
    return await _database!.delete(
      "User",
      where: '${FirebaseFieldName.userId} = ?',
      whereArgs: [user.uid],
    );
  }

  static Future<List<UserModel>?> getAllUsers() async {
    final List<Map<String, dynamic>> maps = await _database!.query("User");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => UserModel.fromJson(json: maps[index]));
  }
}
