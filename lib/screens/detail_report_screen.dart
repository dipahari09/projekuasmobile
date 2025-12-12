import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projekuasmobile/models/report_model.dart';
import 'package:projekuasmobile/providers/report_provider.dart';
import 'edit_report_screen.dart';

class DetailReportScreen extends ConsumerWidget {
  final ReportModel report;

  DetailReportScreen({required this.report});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Laporan"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditReportScreen(report: report),
                ),
              );
              ref.read(reportProvider.notifier).refresh();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await ref.read(reportProvider.notifier).deleteReport(report.id!);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  child: Image.file(File(report.photopath)),
                ),
              );
            },
            child: Image.file(
              File(report.photopath),
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          Text("Judul:", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(report.title),
          SizedBox(height: 16),
          Text("Deskripsi:", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(report.description),
          SizedBox(height: 16),
          Text("Lokasi:", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Lat: ${report.latitude}, Long: ${report.longitude}"),
          SizedBox(height: 16),
          Text("Status:", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(report.status),
        ],
      ),
    );
  }
}