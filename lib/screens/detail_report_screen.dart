import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/report_model.dart';
import '../providers/report_provider.dart';
import 'edit_report_screen.dart';

class DetailReportScreen extends ConsumerWidget {
  final ReportModel report;

  const DetailReportScreen({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(report.title)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (report.photoPath.isNotEmpty)
            Image.file(
              File(report.photoPath),
              height: 250,
              fit: BoxFit.cover,
            ),
          const SizedBox(height: 16),
          Text(
            report.description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text("Lokasi: ${report.latitude}, ${report.longitude}"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditReportScreen(report: report),
                ),
              );
            },
            child: const Text("Edit Laporan"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              final updated = ReportModel(
                id: report.id,
                title: report.title,
                description: "${report.description}\n\n[SELESAI]",
                photoPath: report.photoPath,
                latitude: report.latitude,
                longitude: report.longitude,
                status: 1,
              );

              ref.read(reportProvider.notifier).updateReport(updated);
              Navigator.pop(context);
            },
            child: const Text("Tandai Selesai"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style:
            ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              if (report.id != null) {
                ref.read(reportProvider.notifier).deleteReport(report.id!);
              }
              Navigator.pop(context);
            },
            child: const Text("Hapus Laporan"),
          ),
        ],
      ),
    );
  }
}
