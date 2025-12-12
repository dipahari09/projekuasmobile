class ReportModel {
  final int? id;
  final String title;
  final String description;
  final String photopath;
  final String latitude;
  final String longitude;
  final String status;

  ReportModel({
    this.id,
    required this.title,
    required this.description,
    required this.photopath,
    required this.latitude,
    required this.longitude,
    this.status = "Pending",
});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'photopath': photopath,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      photopath: map['photopath'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      status: map['status'],
    );
  }
}
