// import 'dart:developer';

// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class UserDatabase {
//   Database? _database;
//   List wholeDataList = [];

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//     _database = await _initialize('User.db');
//     return _database!;
//   }

//   Future<Database> _initialize(String filePath) async {
//     final dbpath = await getDatabasesPath();
//     final path = join(dbpath, filePath);
//     var database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDB,
//       singleInstance: true,
//     );
//     return database;
//   }

//   Future<void> _createDB(Database db, int version) async => await db.execute('''
// CREATE TABLE User(id TEXT PRIMARY KEY,
// Name TEXT NOT NULL)
// ''');

//   Future addDataLocally({name}) async {
//     final db = await database;
//     await db.insert('User', {'name': name});
//     log('add success');
//     return 'added';
//   }

//   Future readAllData() async {
//     final db = await database;
//     final alldata = await db.query('User');
//     wholeDataList = alldata;
//     log(wholeDataList.toString());
//     return 'success read';
//   }
// }
