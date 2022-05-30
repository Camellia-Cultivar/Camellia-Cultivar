class Coordinates {
  double latitude;
  double longitude;

  Coordinates({required this.latitude, required this.longitude});

   Map<String, double> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      Coordinates(latitude: json["latitude"], longitude: json["longitude"]);
}