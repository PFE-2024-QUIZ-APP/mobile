// socket_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzapppfe/presentation/widgets/join_widget.dart';

import '../blocs/socket_bloc.dart';

class JoinScreen extends StatelessWidget {
  JoinScreen({super.key});

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();

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
                if (state is SocketJoined) {
                  return Column(children: [
                    Text('Room Name: ${state.roomName}'),
                    Text('User Name: ${state.userName}'),
                    Text('Avatar: ${state.avatar}'),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<SocketBloc>(context)
                            .add(SocketOnDisconnect());
                      },
                      child: const Text('Disconnect Room'),
                    ),

                  ]);
                } else if (state is SocketError) {
                  return Text('Socket error: ${state.error}');
                } else {
                  return JoinWidget(
                      userNameController: _userNameController,
                      roomNameController: _roomNameController,
                      onJoin: () {
                        if (state is! SocketJoined) {
                          BlocProvider.of<SocketBloc>(context).add(
                              SocketOnJoined(_roomNameController.text,
                                  _userNameController.text, "avatar"));
                        }
                      },
                      onDisconnect: () {
                        if (state is! SocketDisconnected) {
                          BlocProvider.of<SocketBloc>(context)
                              .add(SocketOnDisconnect());
                        }
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
