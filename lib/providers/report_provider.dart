import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projekuasmobile/models/report_model.dart';
import 'package:projekuasmobile/db/db_helper.dart';

class ReportNotifier extends StateNotifier<List<ReportModel>> {
  ReportNotifier() : super([]) {
    loadReports();
  }

  Future<void> loadReports() async {
    final data = await DBHelper.getReports();
    state = data;
  }

  Future<void> addReport(ReportModel report) async {
    await DBHelper.insertReport(report);
    await loadReports();
  }

  Future<void> updateReport(ReportModel report) async {
    await DBHelper.updateReport(report);
    await loadReports();
  }

  Future<void> deleteReport(int id) async {
    await DBHelper.deleteReport(id);
    await loadReports();
  }

  Future<void> refresh() async {
    await loadReports();
  }
}

final reportProvider =
StateNotifierProvider<ReportNotifier, List<ReportModel>>(
      (ref) => ReportNotifier(),
);