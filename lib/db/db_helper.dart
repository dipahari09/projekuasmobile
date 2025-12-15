import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/report_model.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> db() async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'eco_patrol.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE reports (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            photoPath TEXT,
            latitude REAL,
            longitude REAL,
            status INTEGER
          )
        ''');
      },
    );
  }

  static Future<int> insertReport(ReportModel report) async {
    final db = await DBHelper.db();
    print("INSERTING: ${report.toMap()}");
    return await db.insert('reports', report.toMap());
  }

  static Future<List<ReportModel>> getReports() async {
    final db = await DBHelper.db();
    final res = await db.query('reports', orderBy: 'id DESC');
    return res.map((e) => ReportModel.fromMap(e)).toList();
  }

  static Future<int> updateReport(ReportModel report) async {
    final db = await DBHelper.db();
    return await db.update(
      'reports',
      report.toMap(),
      where: 'id = ?',
      whereArgs: [report.id],
    );
  }

  static Future<int> deleteReport(int id) async {
    final db = await DBHelper.db();
    return await db.delete(
      'reports',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
