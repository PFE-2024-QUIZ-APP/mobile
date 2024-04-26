import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzapppfe/data/models/questions.dart';
import 'package:quizzapppfe/presentation/widgets/answer_button_widget.dart';
import 'package:quizzapppfe/presentation/widgets/button_widget.dart';

import 'package:quizzapppfe/presentation/widgets/question_timer_widget.dart';
import 'package:quizzapppfe/presentation/widgets/room_players_list_widget.dart';
import '../../constants.dart';
import '../blocs/socket_bloc.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  final int currentQuestion;
  final String? currentUser;

  const QuestionWidget(
      {super.key,
      required this.question, required this.currentQuestion, this.currentUser});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int? selectedAnswerIndex;
  bool answered = false; // To track if the question has been answered
  bool timerEnded = false;
  int timerDuration = 10;

  void handleAnswerClick(int index) {
    if (!answered) { // Check if the question has already been answered
      setState(() {
        selectedAnswerIndex = index;
        answered = true; // Set to true to disable further interaction
      });
      BlocProvider.of<SocketBloc>(context).add(
          SocketOnAnswerQuestion(widget.question.responses[index], widget.currentQuestion)
      );
    }
  }

  void timerEnd() {
    if (!answered) {
      setState(() {
        answered = true;
      });
      BlocProvider.of<SocketBloc>(context).add(
          SocketOnAnswerQuestion("", widget.currentQuestion)
      );
    }
    setState(() {
      timerEnded = true;
    });
  }

  Color getAnswerColor(int index) {
    if(answered){
      if (widget.question.responses[index] == widget.question.rightAnswer && timerEnded) {
        return correct; // Correct answer color
      } else if (index == selectedAnswerIndex && timerEnded) {
        return wrong; // Wrong answer color
      } else {
        return purple; // Default color for non-selected answers
      }
    }else{
      return purple; // Default color for non-selected answers
    }
  }

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<SocketBloc, SocketState>(
          builder: (context, state) {
            if (state is SocketQuestion) {
              if(state.endGame){
                return Column(
                  children: [
                    RoomPlayersList(users: state.responsesPlayers, sortByPoint: true,),
                    if(state.players![0]["id"] == widget.currentUser)
                      ButtonFriizz(text: "Recommencer", primary: true, onClick: () {
                        BlocProvider.of<SocketBloc>(context).add(SocketOnRestart());
                      }),
                  ],
                );
              }else{
                return Container(
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      QuestionTimer(nbSeconds: timerDuration,
                        currentQuestion: widget.currentQuestion,
                        timerEnded: state.timerEnded,
                        onTimerEnd: timerEnd,),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: 100 +
                              (widget.question.responses.length * 100.0),
                          decoration: BoxDecoration(
                            color: blue60,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(24),
                          child: Column(
                              children: [
                                Text(
                                  widget.question.questionText,
                                  style: TextGlobalStyle.buttonStyleWhite,
                                  textAlign: TextAlign.center,
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
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
                                        totalPlayers: answered ? state.players!.length : 1,
                                        answeredPlayers: answered ? state.responsesPlayers.where((element) => element == answer).length : 0,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      // On affichera se bouton soit à la fin du timer soit quand tout le monde à repondu
                      SizedBox(height: 20),
                      state.players![0]["id"] == widget.currentUser && timerEnded
                          ?
                      ButtonFriizz(
                          text: 'Suivant',
                          primary: true,
                          onClick: () {
                            BlocProvider.of<SocketBloc>(context).add(
                                SocketOnNextQuestion());
                          }
                      )
                          : Container(),
                      Spacer(),
                      Container(
                        child: Text("${widget.currentQuestion + 1}/10",
                            style: TextGlobalStyle.nbQuestionStyle),
                        height: 80,
                        width: 120,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          color: blue60,
                        ),
                      )
                    ],
                  ),
                );
              }
            } else {
              return const Text('Socket error: ');
            }
          }
      );
  }
}
