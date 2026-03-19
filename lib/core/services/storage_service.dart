import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  SharedPreferences? _prefs;
  Database? _database;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await _initDb();
  }

  Future<void> _initDb() async {
    if (kIsWeb) return;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'ahlulbayt_companion.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE bookmarks (
            id TEXT PRIMARY KEY,
            type TEXT,
            timestamp INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE khums_entries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT,
            amount REAL,
            description TEXT,
            timestamp INTEGER
          )
        ''');
      },
    );
  }

  // SharedPreferences Methods
  Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  // Database Methods
  Database get database {
    if (kIsWeb) throw Exception("Database not supported on Web");
    if (_database == null) throw Exception("Database not initialized");
    return _database!;
  }
}
