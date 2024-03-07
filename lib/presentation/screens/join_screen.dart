// socket_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzapppfe/presentation/widgets/join_widget.dart';

import '../blocs/socket_bloc.dart';

class JoinScreen extends StatelessWidget {
  JoinScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  get state => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socket Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<SocketBloc, SocketState>(
              builder: (context, state) {
                if (state is SocketConnected) {
                  return const Text('Socket connected');
                } else if (state is SocketJoined) {
                  return Text('Joined room ${state.room}');
                } else if (state is SocketError) {
                  return Text('Socket error: ${state.error}');
                } else {
                  return const Text('Socket disconnected');
                }
              },
            ),
            JoinWidget(
                controller: _controller,
                onJoin: () {
                  if (state is! SocketJoined) {
                    BlocProvider.of<SocketBloc>(context)
                        .add(SocketOnJoined(_controller.text));
                  }
                },
                onDisconnect: () {
                  if (state is! SocketDisconnected) {
                    BlocProvider.of<SocketBloc>(context)
                        .add(SocketOnDisconnect());
                  }
                })
          ],
        ),
      ),
    );
  }
}
