// socket_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzapppfe/presentation/widgets/create_user.dart';

import '../blocs/socket_bloc.dart';

class LobyScreen extends StatelessWidget {
  LobyScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  get state => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lobby Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocListener<SocketBloc,SocketState>(
              listener: (context, state) {
                if (state is SocketJoined) {
                  Navigator.pushNamed(context, '/game');
                }
              },
              child: Text("Join the game"),
            ),
          ],
        ),
      ),
    );
  }
}
