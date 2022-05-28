class UploadedSpecimen {
  DateTime date;
  String location;
  Map<int, String> results;

  UploadedSpecimen(
      {required this.date, required this.location, required this.results});

  Map<String, dynamic> toJson() {
    return {'date': date, 'location': location, 'results': results};
  }

  factory UploadedSpecimen.fromJson(Map<String, dynamic> json) =>
      UploadedSpecimen(
          date: DateTime.parse(json["date"]),
          location: json["location"],
          results: json["results"]);
}
