import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projekuasmobile/models/report_model.dart';
import 'package:projekuasmobile/providers/report_provider.dart';

class EditReportScreen extends ConsumerStatefulWidget {
  final ReportModel report;

  EditReportScreen({required this.report});

  @override
  ConsumerState<EditReportScreen> createState() => _EditReportScreenState();
}

class _EditReportScreenState extends ConsumerState<EditReportScreen> {
  final TextEditingController finishDescController = TextEditingController();
  File? finishPhoto;

  Future<void> pickFinishPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);

    if (picked != null) {
      setState(() {
        finishPhoto = File(picked.path);
      });
    }
  }

  Future<void> saveUpdate() async {
    final updated = ReportModel(
      id: widget.report.id,
      title: widget.report.title,
      description: widget.report.description +
          "\n\nPenyelesaian: ${finishDescController.text}",
      photopath: finishPhoto?.path ?? widget.report.photopath,
      latitude: widget.report.latitude,
      longitude: widget.report.longitude,
      status: "Selesai",
    );

    await ref.read(reportProvider.notifier).updateReport(updated);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tandai Selesai")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            controller: finishDescController,
            decoration: InputDecoration(labelText: "Deskripsi Penyelesaian"),
            maxLines: 3,
          ),
          SizedBox(height: 16),
          finishPhoto == null
              ? Text("Belum ada foto hasil")
              : Image.file(finishPhoto!, height: 200),
          ElevatedButton(
            onPressed: pickFinishPhoto,
            child: Text("Ambil Foto Hasil"),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: saveUpdate,
            child: Text("Tandai Selesai"),
          ),
        ],
      ),
    );
  }
}
