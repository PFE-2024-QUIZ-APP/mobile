import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzapppfe/constants.dart';
import 'package:quizzapppfe/presentation/blocs/socket_bloc.dart';

import '../../blocs/quizz_theme.dart';
import '../../widgets/LogoHeader.dart';
import '../../widgets/button_widget.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  CreateUserState createState() => CreateUserState();
}


class CreateUserState extends State<CreateUser> {
  late TextEditingController _userNameController;
  final List<String> _avatarList = [
    avatar_1,
    avatar_2,
    avatar_3,
    avatar_4,
    avatar_5,
    avatar_6,
    avatar_7,
    avatar_8,
  ];

  String _currentAvatar = avatar_1;

  @override
  void initState() {
    _userNameController = TextEditingController();
    super.initState();
    BlocProvider.of<QuizzBloc>(context).add(LoadItems());

    // Pre-caching avatar images
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _avatarList.forEach((avatar) {
        precacheImage(AssetImage(avatar), context);
      });
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  void selectAvatar(int increment) {
    setState(() {
      _currentAvatar = _avatarList[(_avatarList.indexOf(_currentAvatar) + increment) % _avatarList.length];
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketBloc, SocketState>(builder: (context, state) {
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
                          if (state is! SocketRoomCreated &&
                              _userNameController.text.isNotEmpty) {
                            BlocProvider.of<SocketBloc>(context).add(
                                SocketOnCreateRoom(_userNameController.text,
                                    _avatarList.indexOf(_currentAvatar) + 1));
                            BlocProvider.of<SocketBloc>(context).add(
                                SocketOnCreation(
                                    "create", _userNameController.text, _avatarList.indexOf(_currentAvatar) + 1));
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      ButtonFriizz(
                          text: 'Rejoindre',
                          primary: false,
                          icon: play,
                          onClick: () {
                            if (state is! SocketRoomCreated &&
                                _userNameController.text.isNotEmpty) {
                              BlocProvider.of<SocketBloc>(context).add(
                                  SocketOnCreation(
                                      "join", _userNameController.text, _avatarList.indexOf(_currentAvatar) + 1));
                            }
                          }),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           Container(
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'Choisis ton avatar et ton pseudo',
                        style: TextGlobalStyle.buttonStyleWhite,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () {
                                  HapticFeedback.lightImpact();
                                  selectAvatar(-1);
                                }),
                            Container(
                                decoration:  BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                ),
                                child: Image.asset(_currentAvatar)
                            ),
                            IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  HapticFeedback.lightImpact();
                                  selectAvatar(1);
                                }
                            )
                          ],
                        ),
                      ),
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
        ],
      );
    });
  }

}


