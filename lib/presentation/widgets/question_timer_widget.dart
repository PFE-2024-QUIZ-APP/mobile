import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../blocs/socket_bloc.dart';

class QuestionTimer extends StatefulWidget {
  final int nbSeconds;
  final Function onTimerEnd;
  final int currentQuestion;
  final bool timerEnded;

  const QuestionTimer({super.key, required this.nbSeconds, required this.onTimerEnd, required this.currentQuestion,  this.timerEnded = false});

  @override
  State<QuestionTimer> createState() => _TimerState();
}

class _TimerState extends State<QuestionTimer>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  int _currentNumber = 5;

  @override
  void didUpdateWidget(covariant QuestionTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.timerEnded && _animationController!.isAnimating) {
      _animationController!.stop();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          widget.onTimerEnd();
        }
      });
      setState(() {
        _currentNumber = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _currentNumber = widget.nbSeconds;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );



    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_currentNumber > 0) {
          setState(() {
            _currentNumber -= 1;
          });
          _animationController!.reset();
          _animationController!.forward();
        } else {

          widget.onTimerEnd();
        }
      }
    });

    if (!widget.timerEnded) {
      _animationController!.forward();
    }

  }


  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      decoration: const BoxDecoration(
        color: purple,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         AnimatedBuilder(
              animation: _animationController!,
              builder: (context, child) => Text(
                  '$_currentNumber',
                  style: TextGlobalStyle.questionTimerStyle
                ),
            ),
        ],
      ),
    );
  }
}
