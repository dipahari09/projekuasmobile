import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/db_helper.dart';
import '../models/report_model.dart';

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
}

final reportProvider =
StateNotifierProvider<ReportNotifier, List<ReportModel>>(
      (ref) => ReportNotifier(),
);
