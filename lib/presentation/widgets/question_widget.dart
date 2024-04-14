import 'package:flutter/material.dart';
import 'package:quizzapppfe/presentation/widgets/answer_button_widget.dart';

import '../../constants.dart';

class QuestionWidget extends StatefulWidget {
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
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
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
                      widget.questionText,
                      style: TextGlobalStyle.buttonStyleWhite,
                      textAlign: TextAlign.center,
                    ),
                    Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AnswerBtn(text: widget.responses[0], state: correct, onClick: (){

                              }),
                              AnswerBtn(text: widget.responses[1],  onClick: (){

                              }),
                              AnswerBtn(text: widget.responses[2],  onClick: (){

                              }),
                              AnswerBtn(text: widget.responses[3], state: wrong, onClick: (){

                              }),
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

