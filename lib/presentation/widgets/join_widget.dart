import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JoinWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function() onJoin;
  final Function() onDisconnect;

  const JoinWidget(
      {super.key,
      required this.controller,
      required this.onJoin,
      required this.onDisconnect
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Room Name',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onJoin,
          child: const Text('Join Room'),
        ),
        ElevatedButton(
          onPressed: onDisconnect,
          child: const Text('Disconnect Room'),
        ),
      ],
    );
  }
}
