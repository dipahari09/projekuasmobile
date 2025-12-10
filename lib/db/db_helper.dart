import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/report_model.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> initDb() async {
    if (_db != null) return _db!;
    String path = join(await getDatabasesPath(), 'eco_patrol.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE reports(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            photoPath TEXT,
            latitude REAL,
            longitude REAL,
            status TEXT
          )
        ''');
      },
    );
    return _db!;
  }

  static Future<int> insertReport(ReportModel report) async {
    final db = await initDb();
    return await db.insert('reports', report.toMap());
  }

  static Future<List<ReportModel>> getReports() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.query('reports');
    return List.generate(maps.length, (i) => ReportModel.fromMap(maps[i]));
  }

  static Future<int> updateReport(ReportModel report) async {
    final db = await initDb();
    return await db.update('reports', report.toMap(),
        where: 'id = ?', whereArgs: [report.id]);
  }

  static Future<int> deleteReport(int id) async {
    final db = await initDb();
    return await db.delete('reports', where: 'id = ?', whereArgs: [id]);
  }
}
