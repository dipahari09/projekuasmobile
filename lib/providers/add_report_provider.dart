
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import '../models/report_model.dart';
import '../services/report_repository.dart';
import 'report_list_provider.dart';



final addReportProvider = StateNotifierProvider<AddReportNotifier, ReportInputState>((ref) {
  return AddReportNotifier(ref);
});

class AddReportNotifier extends StateNotifier<ReportInputState> {
  final Ref ref;

  AddReportNotifier(this.ref) : super(ReportInputState());



  Future<bool> submitReport() async {
    if (state.title.isEmpty || state.imagePath == null || state.latitude == null) {
      return false;
    }

    try {
      final newReport = ReportModel(
        title: state.title,
        description: state.description,
        imagePath: state.imagePath!,
        latitude: state.latitude!,
        longitude: state.longitude!,
        status: 'Pending',
      );


      await ref.read(reportRepositoryProvider).insertReport(newReport);


      ref.read(reportListProvider.notifier).refreshReports();

      state = ReportInputState(); // Reset form
      return true;
    } catch (e) {
      return false;
    }
  }
}