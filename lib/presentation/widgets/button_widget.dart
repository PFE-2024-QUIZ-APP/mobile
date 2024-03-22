import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzapppfe/constants.dart';

class ButtonFriizz extends StatelessWidget {
  final String text; // text to display on the button
  final bool primary; // primary color of the button if true = white else purple

  const ButtonFriizz({super.key, required this.text, required this.primary, });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 200,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: primary ? Colors.white : purple,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: primary ? purple : Colors.white ,
              spreadRadius: 0,
              blurRadius: 0,
              offset: const Offset(0, 6), // changes position of shadow
            ),
          ],
        ),
        child: Text(text, style: primary ? TextGlobalStyle.buttonStylePurple : TextGlobalStyle.buttonStyleWhite , textAlign: TextAlign.center,),
      ),
      onTap: () {
        HapticFeedback.lightImpact();
      },
    );
  }
}
