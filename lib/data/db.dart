import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            role TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE vehicles(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            plate TEXT,
            model TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE reports(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            vehicle TEXT,
            driver TEXT
          );
        ''');
      },
    );
  }
}