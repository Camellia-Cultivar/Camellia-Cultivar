class UploadedSpecimen {
  String photo;
  DateTime sumbissionDate;
  String location;
  Map<String, int> results;

  UploadedSpecimen(
      {required this.photo,
      required this.sumbissionDate,
      required this.location,
      required this.results});

  @override
  String toString() {
    return '{photo: $photo, date: $sumbissionDate, location: $location, results $results}';
  }

  factory UploadedSpecimen.fromJson(Map<String, dynamic> json) {
    var date = json["submission"].toString().split("T");
    Map<String, int> map = {};
    (json["cultivarProbabilities"] as Map).forEach((key, value) {
      map[key as String] = value as int;
    });

    return UploadedSpecimen(
        photo: json["photo"],
        sumbissionDate: DateTime.parse(date[0]),
        location: json["address"],
        results: map);
  }
}
