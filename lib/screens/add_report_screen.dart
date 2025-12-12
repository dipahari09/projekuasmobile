import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projekuasmobile/models/report_model.dart';
import 'package:projekuasmobile/providers/report_provider.dart';

class AddReportScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddReportScreen> createState() => _AddReportScreenState();
}

class _AddReportScreenState extends ConsumerState<AddReportScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  File? imageFile;
  double? lat;
  double? long;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  Future<void> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      lat = pos.latitude;
      long = pos.longitude;
    });
  }

  Future<void> saveReport() async {
    if (titleController.text.isEmpty ||
        descController.text.isEmpty ||
        imageFile == null ||
        lat == null ||
        long == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Semua data wajib diisi")),
      );
      return;
    }

    final report = ReportModel(
      title: titleController.text,
      description: descController.text,
      photopath: imageFile!.path,
      latitude: lat,
      longitude: long,
      status: "Pending",
    );

    await ref.read(reportProvider.notifier).addReport(report);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Laporan")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: "Judul Laporan"),
          ),

          TextField(
            controller: descController,
            decoration: InputDecoration(labelText: "Deskripsi"),
            maxLines: 3,
          ),

          SizedBox(height: 16),

          imageFile == null
              ? Text("Belum ada foto")
              : Image.file(imageFile!, height: 200, fit: BoxFit.cover),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.camera_alt),
                label: Text("Kamera"),
                onPressed: () => pickImage(ImageSource.camera),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.photo),
                label: Text("Galeri"),
                onPressed: () => pickImage(ImageSource.gallery),
              ),
            ],
          ),

          SizedBox(height: 16),

          Text(
            lat == null
                ? "Lokasi belum ditandai"
                : "Lokasi: $lat, $long",
          ),

          ElevatedButton(
            onPressed: getLocation,
            child: Text("Tag Lokasi Terkini"),
          ),

          SizedBox(height: 16),

          ElevatedButton(
            onPressed: saveReport,
            child: Text("Simpan Laporan"),
          ),
        ],
      ),
    );
  }
}
