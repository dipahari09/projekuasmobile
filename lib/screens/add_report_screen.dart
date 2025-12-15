import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

import '../models/report_model.dart';
import '../providers/report_provider.dart';

class AddReportScreen extends ConsumerStatefulWidget {
  const AddReportScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddReportScreen> createState() => _AddReportScreenState();
}

class _AddReportScreenState extends ConsumerState<AddReportScreen> {
  final titleC = TextEditingController();
  final descC = TextEditingController();

  String? photoPath;
  double? lat;
  double? lng;

  Future<void> pickPhoto() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        photoPath = img.path;
      });
    }
  }

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      lat = pos.latitude;
      lng = pos.longitude;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Laporan")),
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
            child: const Text("Ambil Foto"),
          ),
          if (photoPath != null) ...[
            const SizedBox(height: 10),
            Image.file(File(photoPath!), height: 200, fit: BoxFit.cover),
          ],
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: getLocation,
            child: const Text("Tag Lokasi Terkini"),
          ),
          if (lat != null && lng != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Lokasi: $lat, $lng"),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final report = ReportModel(
                title: titleC.text,
                description: descC.text,
                photoPath: photoPath ?? "",
                latitude: lat ?? 0,
                longitude: lng ?? 0,
                status: 0, // Pending
              );
              ref.read(reportProvider.notifier).addReport(report);
              Navigator.pop(context);
            },
            child: const Text("Simpan Laporan"),
          ),
        ],
      ),
    );
  }
}
