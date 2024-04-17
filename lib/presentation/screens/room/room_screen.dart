import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzapppfe/presentation/widgets/room_players_list_widget.dart';
import 'package:share/share.dart';

import '../../../../constants.dart';
import '../../blocs/socket_bloc.dart';
import '../../widgets/button_widget.dart';

class RoomScreen extends StatelessWidget {
  RoomScreen({super.key});

  get state => null;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketBloc, SocketState>(builder: (context, state) {
      if (state is SocketJoined) {
        return Expanded(
            child: Column(children: [
          Stack(children: [
            Container(
                decoration: const BoxDecoration(
                    color: blue60,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      '${state.users.length} joueurs',
                      style: TextGlobalStyle.buttonStyleWhite,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Image.asset(close),
                      onPressed: () {
                        BlocProvider.of<SocketBloc>(context)
                            .add(SocketOnDisconnect());
                      },
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: RoomPlayersList(users: state.users),
            ),
          ]),
          const Spacer(),
          ButtonFriizz(
              icon: share,
              text: "Inviter",
              primary: true,
              onClick: () {
                Share.share(
                    'Rejoins moi sur Friizz pour jouer ensemble, code : ${state.roomName}');
              }),
          const SizedBox(height: 24),
          ButtonFriizz(
              icon: play, text: "Démarrer", primary: false, onClick: () {})
        ]));
      } else {
        return const Text('Socket error: ');
      }
    });
  }
}
