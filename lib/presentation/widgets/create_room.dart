import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzapppfe/constants.dart';
import 'package:quizzapppfe/presentation/blocs/socket_bloc.dart';

import 'button_widget.dart';

class CreateRoom extends StatelessWidget {
  final TextEditingController _roomNameController = TextEditingController();

  CreateRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketBloc,SocketState>(
        builder: (context, state) {
          if(state is SocketCreationRoom){
            return Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(logo),
                        Column(
                          children: [
                            ButtonFriizz(
                              text: state.typeCreation == "create" ? 'Créez le salon' : 'Rejoindre',
                              primary: true,
                              icon: play,
                              onClick: () {
                                if (state is! SocketJoined) {
                                  BlocProvider.of<SocketBloc>(context).add(
                                      SocketOnJoined(_roomNameController.text, state.userName, "avatar"));
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
                            Text('Entre le numéro de ta room', style: TextGlobalStyle.buttonStyleWhite, textAlign: TextAlign.center,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,),
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
                                      decoration: InputDecoration(
                                        hintText: 'Entre un nom de room',
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.all(0),
                                        hintStyle: TextGlobalStyle.buttonStyleWhite,
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
          else{
            return Text('');
          }
        }
    );
  }
}
