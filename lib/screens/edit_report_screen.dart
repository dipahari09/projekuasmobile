import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/report_model.dart';
import '../providers/report_provider.dart';

class EditReportScreen extends ConsumerStatefulWidget {
  final ReportModel report;

  const EditReportScreen({Key? key, required this.report}) : super(key: key);

  @override
  ConsumerState<EditReportScreen> createState() => _EditReportScreenState();
}

class _EditReportScreenState extends ConsumerState<EditReportScreen> {
  late TextEditingController titleC;
  late TextEditingController descC;
  String? photoPath;

  @override
  void initState() {
    super.initState();
    titleC = TextEditingController(text: widget.report.title);
    descC = TextEditingController(text: widget.report.description);
    photoPath = widget.report.photoPath;
  }

  Future<void> pickPhoto() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        photoPath = img.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Laporan")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleC,
            decoration: const InputDecoration(labelText: "Judul Laporan"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descC,
            maxLines: 3,
            decoration: const InputDecoration(labelText: "Deskripsi"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: pickPhoto,
            child: const Text("Ganti Foto"),
          ),
          if (photoPath != null && photoPath!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.file(
                File(photoPath!),
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final updated = ReportModel(
                id: widget.report.id,
                title: titleC.text,
                description: descC.text,
                photoPath: photoPath ?? "",
                latitude: widget.report.latitude,
                longitude: widget.report.longitude,
                status: widget.report.status,
              );

              ref.read(reportProvider.notifier).updateReport(updated);
              Navigator.pop(context);
            },
            child: const Text("Simpan Perubahan"),
          ),
        ],
      ),
    );
  }
}
