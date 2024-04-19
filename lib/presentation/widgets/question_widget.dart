import 'package:flutter/material.dart';
import 'package:quizzapppfe/data/models/questions.dart';
import 'package:quizzapppfe/presentation/widgets/answer_button_widget.dart';
import 'package:quizzapppfe/presentation/widgets/question_timer_widget.dart';
import '../../constants.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;

  const QuestionWidget({super.key, required this.question});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int? selectedAnswerIndex;
  bool answered = false; // To track if the question has been answered

  void handleAnswerClick(int index) {
    if (!answered) { // Check if the question has already been answered
      setState(() {
        selectedAnswerIndex = index;
        answered = true; // Set to true to disable further interaction
      });
    }
  }

  Color getAnswerColor(int index) {
    if (!answered) {
      return purple; // Default color if not answered
    } else if (widget.question.responses[index] == widget.question.rightAnswer) {
      return correct; // Correct answer color
    } else if (index == selectedAnswerIndex) {
      return wrong; // Wrong answer color
    } else {
      return purple; // Default color for non-selected answers
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        QuestionTimer(nbSeconds: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Container(
            height: 100 + (widget.question.responses.length * 100.0),
            decoration: BoxDecoration(
              color: blue60,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              Text(
                widget.question.questionText,
                style: TextGlobalStyle.buttonStyleWhite,
                textAlign: TextAlign.center,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.question.responses
                      .asMap()
                      .entries
                      .map<Widget>((entry) {
                    int idx = entry.key;
                    String answer = entry.value;
                    return AnswerBtn(
                      text: answer,
                      state: getAnswerColor(idx),
                      onClick: () => handleAnswerClick(idx),
                    );
                  }).toList(),
                ),
              ),
            ]),
          ),
        ),
        Spacer(),
        Container(
          child: Text("1/10", style: TextGlobalStyle.nbQuestionStyle),
          height: 80,
          width: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            color: blue60,
          ),
        )
      ],
    );
  }
}
