import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 2, // ⬅️ bump version
      onCreate: (db, version) async {
        await db.execute(_createProductsTableV2());
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE products ADD COLUMN is_synced INTEGER DEFAULT 1',
          );
        }
      },
    );
  }

  String _createProductsTableV2() {
    return '''
      CREATE TABLE products(
        id TEXT PRIMARY KEY,
        name TEXT,
        price INTEGER,
        description TEXT,
        status TEXT,
        updatedAt TEXT,
        is_synced INTEGER DEFAULT 1
      )
    ''';
  }
}
