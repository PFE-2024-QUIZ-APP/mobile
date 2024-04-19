import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../blocs/socket_bloc.dart';

class QuestionTimer extends StatefulWidget {
  final int nbSeconds;
  final Function? onTimerEnd;

  const QuestionTimer({super.key, required this.nbSeconds, this.onTimerEnd});

  @override
  State<QuestionTimer> createState() => _TimerState();
}

class _TimerState extends State<QuestionTimer>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  int _currentNumber = 5;

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
          // Timer has reached zero, trigger action here
          _onTimerEnd();
        }
      }
    });

    _animationController!.forward();
  }

  void _onTimerEnd() {
    final socketBloc = BlocProvider.of<SocketBloc>(context);
    final socketState = socketBloc.state;

    if (socketState is SocketLaunchGame) {
      // Assuming SocketLoaded is a valid state
      print(socketState.question);
      socketBloc
          .add(SocketOnQuestion(socketState.question, socketState.creator));
    } else {
      // Handle other states or show an error
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
      alignment: Alignment.center,
      child: Center(
        child: AnimatedBuilder(
          animation: _animationController!,
          builder: (context, child) => Text(
              '$_currentNumber',
              style: TextGlobalStyle.questionTimerStyle
            ),

        ),
      ),
    );
  }
}
