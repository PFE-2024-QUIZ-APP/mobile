import 'package:flutter/material.dart';

import '../../constants.dart';

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
        setState(() {
          _currentNumber -= 1;
        });
        if (_currentNumber > 0) {
          _animationController!.reset();
          _animationController!.forward();
        }
      }
    });

    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: BackgroundGradient,
        ),
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
      ),
    );
  }
}
