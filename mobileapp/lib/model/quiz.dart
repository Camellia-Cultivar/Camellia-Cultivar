class Quiz {
  //List<Question> questions;
  List<String> questions;

  Quiz({required this.questions});

  Map<String, dynamic> toJson() {
    return {'questions': questions};
  }

  //factory Quiz.fromJson(Map<String, dynamic> json) =>
  // Todo: map de questions
}
