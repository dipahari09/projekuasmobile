import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projekuasmobile/models/report_model.dart';
import 'package:projekuasmobile/db/db_helper.dart';

class ReportNotifier extends StateNotifier<List<ReportModel>> {
  ReportNotifier() : super([]) {
    loadReports();
  }

  // ✅ Load semua laporan dari database
  Future<void> loadReports() async {
    final data = await DBHelper.getReports();
    state = data;
  }

  // ✅ Insert laporan baru (Mahasiswa 2)
  Future<void> addReport(ReportModel report) async {
    await DBHelper.insertReport(report);
    await loadReports(); // refresh otomatis
  }

  // ✅ Update laporan (Mahasiswa 4)
  Future<void> updateReport(ReportModel report) async {
    await DBHelper.updateReport(report);
    await loadReports();
  }

  // ✅ Delete laporan (Mahasiswa 4)
  Future<void> deleteReport(int id) async {
    await DBHelper.deleteReport(id);
    await loadReports();
  }

  // ✅ Refresh manual (dipakai setelah edit)
  Future<void> refresh() async {
    await loadReports();
  }
}

// ✅ Provider utama yang dipakai Mahasiswa 2, 3, dan 4
final reportProvider =
StateNotifierProvider<ReportNotifier, List<ReportModel>>(
      (ref) => ReportNotifier(),
);