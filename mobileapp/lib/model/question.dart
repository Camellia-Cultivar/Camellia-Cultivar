import 'dart:convert';

List<Question> QuestionFromJson(String str) =>
    List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

class Question {
  int specimenId;
  List<String> images;

  Question({required this.specimenId, required this.images});

  Map<String, dynamic> toJson() {
    return {'specimenId': specimenId, 'images': images};
  }

  factory Question.fromJson(Map<String, dynamic> json) =>
      Question(specimenId: json["specimenId"], images: json["images"]);
}
