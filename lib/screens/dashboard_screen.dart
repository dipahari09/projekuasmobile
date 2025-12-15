import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/report_provider.dart';
import '../models/report_model.dart';
import 'add_report_screen.dart';
import 'detail_report_screen.dart';
import 'settings_screen.dart';
import 'summary_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  Color _statusColor(int status) {
    return status == 1 ? Colors.green : Colors.red;
  }

  String _statusText(int status) {
    return status == 1 ? "Selesai" : "Pending";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(reportProvider);

    final total = reports.length;
    final selesai = reports.where((e) => e.status == 1).length;
    final pending = reports.where((e) => e.status == 0).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("EcoPatrol Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddReportScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          SummaryCard(
            total: total,
            selesai: selesai,
            pending: pending,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final ReportModel r = reports[index];
                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    title: Text(r.title),
                    subtitle: Text(r.description),
                    leading: Icon(Icons.circle, color: _statusColor(r.status)),
                    trailing: Text(
                      _statusText(r.status),
                      style: TextStyle(
                        color: _statusColor(r.status),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailReportScreen(report: r),
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
