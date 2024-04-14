import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzapppfe/data/models/questions.dart';

class Quizz {
  final String uid;
  final String name;
  final List<Question> questions;

  Quizz({required this.uid, required this.name, required this.questions});

  factory Quizz.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // Assuming 'questions' is a List of Maps in Firestore
    List<Question> parsedQuestions = [];
    if (data['questions'] != null) {
      var questionsFromFirestore = List<dynamic>.from(data['questions']);
      parsedQuestions = questionsFromFirestore.map<Question>((questionData) => Question.fromMap(questionData)).toList();
    }
    return Quizz(
      uid: doc.id,
      name: data['name'] ?? '',
      questions: parsedQuestions,
    );
  }
}
