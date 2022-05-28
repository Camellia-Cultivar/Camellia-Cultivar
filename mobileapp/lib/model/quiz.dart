import 'question.dart';

class Quiz {
  List<Question> questions;

  Quiz({required this.questions});

  Map<String, dynamic> toJson() {
    return {'questions': questions};
  }

//TODO: confirm this is right
// transform to map to list: mapData.entries.map( (entry) => Weight(entry.key, entry.value)).toList();
  factory Quiz.fromJson(List<Map<String, dynamic>> json) {
    List<Question> q = [];

    for (Map<String, dynamic> o in json) {
      q.add(Question.fromJson(o));
    }

    return Quiz(questions: q);
  }
}
