

class Question {
  final String name;
  final String questiontext;
  final List<String> responses;
  final String rightAnswer;
  final String type;

  Question({required this.name, required this.questiontext, required this.responses, required this.rightAnswer, required this.type});

  factory Question.fromMap(Map<String, dynamic> data) {
    return Question(
      name: data['name'] ?? '',
      questiontext: data['questiontext'] ?? '',
      responses: List<String>.from(data['responses'] ?? []),
      rightAnswer: data['rightAnswer'] ?? '',
      type: data['type'] ?? '',
    );
  }
}
