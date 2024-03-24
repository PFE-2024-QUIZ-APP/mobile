import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizzapppfe/constants.dart';
import 'package:quizzapppfe/presentation/blocs/socket_bloc.dart';

import 'button_widget.dart';

class CreateUser extends StatelessWidget {
  final TextEditingController _userNameController = TextEditingController();

 CreateUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketBloc,SocketState>(
      builder: (context, state) {
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
                          height: 81,
                          width: 180,),
                        Column(
                          children: [
                            ButtonFriizz(
                              text:'Créer un salon',
                              primary: true,
                              icon: play,
                              onClick: () {
                                if (state is! SocketCreationRoom && _userNameController.text.isNotEmpty) {
                                  BlocProvider.of<SocketBloc>(context).add(
                                      SocketOnCreation("create", _userNameController.text));
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            ButtonFriizz(
                                text:'Rejoindre',
                                primary: false,
                                icon: play,
                                onClick: () {
                                  if (state is! SocketCreationRoom && _userNameController.text.isNotEmpty) {
                                    BlocProvider.of<SocketBloc>(context).add(
                                        SocketOnCreation("join", _userNameController.text));
                                  }
                                }
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
                            const Text('Choisis ton AVATAR et ton PSEUDO', style: TextGlobalStyle.buttonStyleWhite, textAlign: TextAlign.center,),
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
                                      controller: _userNameController,
                                      decoration: const InputDecoration(
                                        hintText: 'Entre un pseudo',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(0),
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
    );
  }
}
