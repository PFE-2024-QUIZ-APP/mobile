import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizzapppfe/constants.dart';

class AnswerBtn extends StatelessWidget {
  final String text; // text to display on the button
  final Color state; // Color to indicate state of the button
  final int totalPlayers; // Total number of players
  final int answeredPlayers; // Number of players who have answered
  final Function onClick;

  const AnswerBtn({super.key, required this.text, required this.state, required this.onClick, required this.totalPlayers, required this.answeredPlayers});

  @override
  Widget build(BuildContext context) {
    final fillRatio = (answeredPlayers / totalPlayers).clamp(0.0, 1.0);

    return InkWell(
      child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset(0, 6), // changes position of shadow
              ),
            ],
          ),
        child: Stack(
          children: [
            // Background color
            Container(
              decoration: BoxDecoration(
                color: state == purple ? purple : state.withOpacity(0.6), // Base color with reduced opacity
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            // Foreground filled color
            FractionallySizedBox(
              widthFactor: fillRatio,
              child: Container(
                decoration: BoxDecoration(
                  color: state == purple ? darkPurple : state,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            // Text
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  text,
                  style: TextGlobalStyle.answerButtonStyleWhite,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        HapticFeedback.lightImpact();
        onClick();
      },
    );
  }
}

