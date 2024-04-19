import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzapppfe/constants.dart';
import 'package:quizzapppfe/presentation/blocs/quizz_theme.dart';
import 'package:quizzapppfe/presentation/blocs/socket_bloc.dart';

import '../../widgets/LogoHeader.dart';
import '../../widgets/button_widget.dart';

class CreateRoom extends StatefulWidget {
  CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  String uidQuizz = "";

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _roomNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketBloc, SocketState>(builder: (context, state) {
      if (state is SocketRoomCreated) {
        if (state.typeCreation == "create") {
          return Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LogoHeader(),
                      Column(
                        children: [
                          ButtonFriizz(
                            text: 'Créer un salon',
                            primary: true,
                            icon: play,
                            onClick: () {
                              if (state is! SocketJoined &&
                                  uidQuizz.isNotEmpty) {
                                BlocProvider.of<SocketBloc>(context).add(
                                    SocketOnCreateRoom(uidQuizz, state.userName,
                                        state.avatar));
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
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
              ),
            ],
          );
        } else {
          return Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LogoHeader(),
                      Column(
                        children: [
                          ButtonFriizz(
                            text: 'Rejoindre',
                            primary: true,
                            icon: play,
                            onClick: () {
                              if (state is! SocketJoined &&
                                  _roomNameController.text.isNotEmpty) {
                                BlocProvider.of<SocketBloc>(context).add(
                                    SocketOnJoin(_roomNameController.text,
                                        state.userName, state.avatar));
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
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
                            'Entre le numéro de ta room',
                            style: TextGlobalStyle.buttonStyleWhite,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: lightBlue,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 4,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextField(
                                    controller: _roomNameController,
                                    decoration: const InputDecoration(
                                      hintText: 'Entre un nom de room',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(0),
                                      hintStyle:
                                          TextGlobalStyle.buttonStyleWhite,
                                    ),
                                    style: TextGlobalStyle.buttonStyleWhite,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        }
      } else {
        return Text('');
      }
    });
  }
}
