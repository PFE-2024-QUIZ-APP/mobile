import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzapppfe/presentation/blocs/quizz_theme.dart';
import 'package:quizzapppfe/presentation/widgets/room_players_list_widget.dart';
import 'package:share/share.dart';


import '../../../../constants.dart';
import '../../blocs/socket_bloc.dart';
import '../../widgets/button_widget.dart';

class RoomScreen extends StatefulWidget {
  RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  bool isSettings = false;

  String uidQuizz = "";

  get state => null;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketBloc, SocketState>(builder: (context, state) {
      if (state is SocketJoined) {
        return Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom:10.0),
            child: Text(
              'Room: ${state.roomName}',
              style: TextGlobalStyle.buttonStyleWhite,
            ),
          ),
          if (isSettings) ListTheme(context) else Stack(children: [
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
              icon: play,
              text: "Démarrer",
              primary: false,
              onClick: () {
                BlocProvider.of<SocketBloc>(context).add(SocketOnLaunchGame(state.roomName));
              }
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isSettings = true;

                  });
                },
                child: const Text(
                  'Settings',
                  style: TextGlobalStyle.buttonStyleWhite,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isSettings = false;
                  });
                },
                child: const Text(
                  'Players',
                  style: TextGlobalStyle.buttonStyleWhite,
                ),
              )
            ],
          )
        ]);
      } else {
        return const Text('Socket error: ');
      }
    });
  }

  Widget ListTheme(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Choisi un theme',
                  style: TextGlobalStyle.buttonStyleWhite,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<QuizzBloc, QuizzThemeState>(
                    builder: (context, state) {
                      if (state is QuizzThemeLoading) {
                        return CircularProgressIndicator();
                      } else if (state is QuizzThemeLoaded) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.quizzes.length,
                          itemBuilder: (context, index) {
                            final item = state.quizzes[index];
                            bool selected = uidQuizz == item.uid;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: ButtonFriizz(
                                  text: item.name,
                                  primary: selected ? false : true,
                                  onClick: () {
                                    HapticFeedback.lightImpact();
                                    setState(() {
                                      uidQuizz = item.uid;
                                    });
                                    BlocProvider.of<SocketBloc>(context).add(
                                        SocketOnChangeTheme(item.uid));
                                  }),
                            );
                          },
                        );
                      } else if (state is QuizzThemeError) {
                        return Text('Error fetching items');
                      }
                      return Container();
                    })
              ],
            ),
          ),
        )
      ],
    );
  }
}
