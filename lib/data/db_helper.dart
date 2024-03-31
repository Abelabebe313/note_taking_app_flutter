import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "note.db";
  static final DatabaseHelper instance = DatabaseHelper._internal();

  factory DatabaseHelper() => instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: 1, onCreate: _createTables);
  }

  void _createTables(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS note (
      id TEXT PRIMARY KEY,
      title TEXT NOT NULL,
      content TEXT,
      createdAt TEXT,
      updatedAt TEXT,
      tag TEXT
    );
  ''');
    
  }
}
