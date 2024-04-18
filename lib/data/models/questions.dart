

class Question {
  final String questionText;
  final List<String> responses;
  final String rightAnswer;
  final String type;

  Question({ required this.questionText, required this.responses, required this.rightAnswer, required this.type});

  factory Question.fromMap(Map<String, dynamic> data) {
    return Question(
      questionText: data['questionText'] ?? '',
      responses: List<String>.from(data['responses'] ?? []),
      rightAnswer: data['rightAnswer'] ?? '',
      type: data['type'] ?? '',
    );
  }
}
