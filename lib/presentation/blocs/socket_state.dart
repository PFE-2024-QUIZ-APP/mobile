part of 'socket_bloc.dart';

abstract class SocketState  extends Equatable{

}

class SocketInitial extends SocketState {
  @override
  List<Object> get props => [];
}

class SocketConnecting extends SocketState {
  @override
  List<Object> get props => [];
}

class SocketConnected extends SocketState {
  @override
  List<Object> get props => [];
}

class SocketJoined extends SocketState {
  final String roomName;
  final List users;
  SocketJoined(this.roomName, this.users);
  @override
  List<Object> get props => [roomName, users];
}

class SocketDisconnected extends SocketState {
  @override
  List<Object> get props => [];
}

class SocketError extends SocketState {
  final String error;
  SocketError(this.error);
  @override
  List<Object> get props => [error];
}

class SocketRoomCreated extends SocketState {
  final String userName;
  final int avatar;
  SocketRoomCreated(this.userName, this.avatar, );
  @override
  List<Object> get props => [userName, avatar];
}

class SocketQuestion extends SocketState {
  final Question;
  SocketQuestion(this.Question);
  @override
  List<Object> get props => [Question];
}


class SocketLaunchGame extends SocketState {
  final Question question;
  final bool creator;
  SocketLaunchGame(this.question, this.creator);
  @override
  List<Object> get props => [Question];
}
