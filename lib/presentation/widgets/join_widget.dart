import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JoinWidget extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController  roomNameController;
  final Function() onJoin;
  final Function() onDisconnect;

  const JoinWidget(
      {super.key,
      required this.userNameController,
      required this.roomNameController,
      required this.onJoin,
      required this.onDisconnect
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: userNameController,
                decoration: const InputDecoration(
                  labelText: 'User Name',
                ),
              ),
              TextField(
                controller: roomNameController,
                decoration: const InputDecoration(
                  labelText: 'Room Name',
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: onJoin,
          child: const Text('Join Room'),
        ),

      ],
    );
  }
}
