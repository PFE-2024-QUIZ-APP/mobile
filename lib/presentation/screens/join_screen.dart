// socket_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzapppfe/presentation/widgets/create_room.dart';
import 'package:quizzapppfe/presentation/widgets/create_user.dart';

import '../../constants.dart';
import '../blocs/socket_bloc.dart';
import '../widgets/button_widget.dart';

class JoinScreen extends StatelessWidget {
  JoinScreen({super.key});

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();

  get state => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
         gradient: BackgroundGradient,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<SocketBloc, SocketState>(
          builder: (context, state) {
            if (state is SocketJoined) {
              return Column(children: [
                Text('Room Name: ${state.roomName}'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return Text('Player: ${user["name"]}');
                  },
                ),
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
            }else if (state is SocketCreationRoom) {
              return SafeArea(child: CreateRoom());
            } else {
              return SafeArea(
                child: CreateUser()
              );
            }
          },
        ),
      ),
    );
  }
}
