import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizzapppfe/constants.dart';

class AnswerBtn extends StatelessWidget {
  final String text; // text to display on the button
  final Color state; // neutral, correct, wrong
  final Function onClick;

  const AnswerBtn({super.key, required this.text,this.state = purple,  required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: state,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              text,
              style: TextGlobalStyle.answerButtonStyleWhite,
              textAlign: TextAlign.center,
            ),
          )),
      onTap: () {
        HapticFeedback.lightImpact();
        onClick();
      },
    );
  }
}

