import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final int total;
  final int selesai;

  const SummaryCard({
    required this.total,
    required this.selesai,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total: $total",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("Selesai: $selesai",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}