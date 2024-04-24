part of 'socket_bloc.dart';

abstract class SocketState  extends Equatable{
  final String? idUser;
  final List? players;
  SocketState(this.idUser, this.players);
  @override
  List<Object?> get props => [idUser];
}

class SocketInitial extends SocketState {
  SocketInitial(String? idUser,List? players) : super(idUser, players);
  @override
  List<Object> get props => [];
}

class SocketConnecting extends SocketState {
  SocketConnecting(String? idUser,List? players) : super(idUser, players);
  @override
  List<Object> get props => [];
}

class SocketConnected extends SocketState {
  SocketConnected(String? idUser,List? players) : super(idUser, players);
  @override
  List<Object> get props => [];
}

class SocketJoined extends SocketState {
  final String roomName;
  final List users;
  SocketJoined(String? idUser,List? players,this.roomName, this.users) : super(idUser, players);
  @override
  List<Object> get props => [roomName, users];
}

class SocketDisconnected extends SocketState {
  SocketDisconnected(String? idUser,List? players) : super(idUser, players);
  @override
  List<Object> get props => [];
}

class SocketError extends SocketState {
  final String error;
  SocketError(String? idUser,List? players,this.error) : super(idUser, players);
  @override
  List<Object> get props => [error];
}

class SocketRoomCreated extends SocketState {
  final String userName;
  final int avatar;
  SocketRoomCreated(String? idUser,List? players,this.userName, this.avatar, ):super(idUser, players);
  @override
  List<Object> get props => [userName, avatar];
}

class SocketQuestion extends SocketState {
  final Question;
  final List responsesPlayers;
  final int currentQuestion;
  SocketQuestion(String? idUser,List? players, this.Question, this.currentQuestion, this.responsesPlayers) : super(idUser, players);
  @override
  List<Object> get props => [Question];
}


class SocketLaunchTimer extends SocketState {
  final Question question;
  final bool creator;
  final int currentQuestion;
  SocketLaunchTimer(String? idUser,List? players, this.question, this.creator, this.currentQuestion): super(idUser, players);
  @override
  List<Object> get props => [Question];
}
