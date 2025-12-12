import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projekuasmobile/providers/report_provider.dart';
import 'package:projekuasmobile/screens/detail_report_screen.dart';
import 'summary_card.dart';

class DashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(reportProvider);

    final total = reports.length;
    final selesai = reports.where((r) => r.status == "Selesai").length;

    return Scaffold(
      appBar: AppBar(title: Text("Dashboard Laporan")),
      body: Column(
        children: [

          SummaryCard(total: total, selesai: selesai),

          SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];

                return Card(
                  child: ListTile(
                    leading: Image.file(
                      File(report.photopath),
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),

                    title: Text(report.title),
                    subtitle: Text(report.description),

                    trailing: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: report.status == "Pending"
                            ? Colors.red
                            : Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        report.status,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailReportScreen(report: report),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}