import 'package:flutter/material.dart';
import 'package:quizzapppfe/presentation/widgets/answer_button_widget.dart';

import '../../constants.dart';

class QuestionWidget extends StatelessWidget {
  final String questionText;
  final List<String> responses;
  final List<String> rightAnswer;
  final String types;

  const QuestionWidget(
      {super.key,
      required this.questionText,
      required this.responses,
      required this.rightAnswer,
      required this.types});

  @override
  Widget build(BuildContext context) {
      return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    color: blue60,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                      children: [
                    Text(
                      questionText,
                      style: TextGlobalStyle.buttonStyleWhite,
                      textAlign: TextAlign.center,
                    ),
                    Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AnswerBtn( text: "text", state: correct, onClick: (){}),
                              AnswerBtn(text: "text",  onClick: (){}),
                              AnswerBtn(text: "text",  onClick: (){}),
                              AnswerBtn(text: "text", state: wrong, onClick: (){}),
                            ],
                          ),
                        )
                  ]),
                ),
              )
            ],
          );
  }
}

