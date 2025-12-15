import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final int total;
  final int selesai;
  final int pending;

  const SummaryCard({
    Key? key,
    required this.total,
    required this.selesai,
    required this.pending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text("Total"),
                Text(total.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                const Text("Selesai"),
                Text(selesai.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                const Text("Pending"),
                Text(pending.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
