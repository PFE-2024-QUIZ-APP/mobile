// socket_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzapppfe/presentation/screens/creation/create_room_screen.dart';
import 'package:quizzapppfe/presentation/screens/creation/create_user_screen.dart';
import 'package:quizzapppfe/presentation/screens/room/room_screen.dart';
import 'package:quizzapppfe/presentation/widgets/timer_widget.dart';

import '../../../constants.dart';
import '../../blocs/socket_bloc.dart';
import '../../widgets/question_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  get state => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: const BoxDecoration(
          gradient: BackgroundGradient,
        ),
        child: BlocBuilder<SocketBloc, SocketState>(
          builder: (context, state) {
            if (state is SocketJoined) {
              return SafeArea(child: RoomScreen());
            } else if (state is SocketError) {
              return Text('Socket error: ${state.error}');
            } else if (state is SocketRoomCreated) {
              return SafeArea(child: CreateRoom());
            }else if(state is SocketLaunchGame) {
              return const Timer();
            }else if(state is SocketQuestion){
              return QuestionWidget(question:state.Question);
          }else {
              return const SafeArea(child: CreateUser());
            }
          },
        ),
      ),
    );
  }
}
