class ReportModel {
  int? id;
  String title;
  String description;
  String photoPath;
  double latitude;
  double longitude;
  String status;

  ReportModel({
    this.id,
    required this.title,
    required this.description,
    required this.photoPath,
    required this.latitude,
    required this.longitude,
    required this.status,
  });

Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'photopath': photoPath,
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
      photoPath: map['photopath'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      status: map['status'],
    );
  }
}
