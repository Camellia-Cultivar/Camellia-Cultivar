import 'dart:convert';

List<Question> QuestionFromJson(String str) =>
    List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

class Question {
  int specimenId;
  List<String> images;

  Question({required this.specimenId, required this.images});

  @override
  String toString() {
    return 'specimenId: $specimenId, images: $images';
  }

  Map<String, dynamic> toJson() {
    return {'specimenId': specimenId, 'images': images};
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    List<String> _images = [];
    _images = (json["photographs"] as List)
        .map((imageUrl) => imageUrl.toString())
        .toList();
    return Question(specimenId: json["specimenId"], images: _images);
  }
}
