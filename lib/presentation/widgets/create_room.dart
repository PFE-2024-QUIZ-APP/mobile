import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quizzapppfe/constants.dart';
import 'package:quizzapppfe/presentation/blocs/quizz_theme.dart';
import 'package:quizzapppfe/presentation/blocs/socket_bloc.dart';
import 'package:quizzapppfe/presentation/models/quizzes.dart';

import 'button_widget.dart';

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
    BlocProvider.of<QuizzBloc>(context).add(LoadItems());
  }

  final TextEditingController _roomNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketBloc,SocketState>(
        builder: (context, state) {
          if(state is SocketCreationRoom){
            if(state.typeCreation == "create") {
              return Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(logoSVG,
                            height: 80,
                            width: 180,),
                          Column(
                            children: [
                              ButtonFriizz(
                                text: 'Créer un salon',
                                primary: true,
                                icon: play,
                                onClick: () {
                                  if (state is! SocketJoined && uidQuizz.isNotEmpty) {
                                    BlocProvider.of<SocketBloc>(context).add(
                                        SocketOnCreateRoom(uidQuizz,
                                            state.userName, "avatar"));
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
                              Text('Choisi un theme',
                                style: TextGlobalStyle.buttonStyleWhite,
                                textAlign: TextAlign.center,),
                              SizedBox(height: 20,),
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
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
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
                                  }
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }else {
              return Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(logoSVG,
                            height: 80,
                            width: 180,),
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
                                        SocketOnJoined(_roomNameController.text,
                                            state.userName, "avatar"));
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
                              Text('Choisi un theme',
                                style: TextGlobalStyle.buttonStyleWhite,
                                textAlign: TextAlign.center,),
                              SizedBox(height: 20,),
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
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            child: ButtonFriizz(
                                                text: item.name,
                                                primary: true,
                                                onClick: () {
                                                  HapticFeedback.lightImpact();
                                                }),
                                          );
                                        },
                                      );
                                    } else if (state is QuizzThemeError) {
                                      return Text('Error fetching items');
                                    }
                                    return Container();
                                  }
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
          }
          else{
            return Text('');
          }
        }
    );
  }
}
