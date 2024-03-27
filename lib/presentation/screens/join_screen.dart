// socket_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzapppfe/presentation/widgets/create_room.dart';
import 'package:quizzapppfe/presentation/widgets/create_user.dart';
import 'package:quizzapppfe/presentation/widgets/room_players_list_widget.dart';
import 'package:share/share.dart';

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
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          gradient: BackgroundGradient,
        ),
        child: BlocBuilder<SocketBloc, SocketState>(
          builder: (context, state) {
            if (state is SocketJoined) {
              return SafeArea(
                child: Column(
                children: [
                  Text('Room Name: ${state.roomName}', style: TextGlobalStyle.buttonStyleWhite),
                  Text('${state.users.length} joueurs', style: TextGlobalStyle.buttonStyleWhite),
                  RoomPlayersList(users: state.users),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<SocketBloc>(context)
                          .add(SocketOnDisconnect());
                    },
                    child: const Text('Disconnect Room'),
                  ),
                  ButtonFriizz(
                      icon: share,
                      text: "Inviter",
                      primary: true,
                      onClick: () {
                        Share.share(
                            'Rejoins moi sur Friizz pour jouer ensemble, code : ${state.roomName}');
                      }),
                  SizedBox(height: 24),
                  ButtonFriizz(
                      icon: play,
                      text: "Démarrer",
                      primary: false,
                      onClick: () {})
                ]),
              );
            } else if (state is SocketError) {
              return Text('Socket error: ${state.error}');
            } else if (state is SocketCreationRoom) {
              return SafeArea(child: CreateRoom());
            } else {
              return SafeArea(child: CreateUser());
            }
          },
        ),
      ),
    );
  }
}
