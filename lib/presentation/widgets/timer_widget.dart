import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../blocs/socket_bloc.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _scaleAnimation;
  Animation<double>? _opacityAnimation;
  int _currentNumber = 5;


  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.elasticOut,
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController!);

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


    if (socketState is SocketLaunchTimer) { // Assuming SocketLoaded is a valid state
      print(socketState.question);
      socketBloc.add(SocketOnQuestion(socketState.question, socketState.creator, socketState.currentQuestion,[]));
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
      child: Center(
        child: AnimatedBuilder(
          animation: _animationController!,
          builder: (context, child) => Opacity(
            opacity: _opacityAnimation!.value,
            child: Transform.scale(
              scale: _scaleAnimation!.value,
              child: Text(
                '$_currentNumber',
                style: TextGlobalStyle.timerStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
