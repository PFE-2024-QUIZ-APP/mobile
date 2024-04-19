part of 'socket_bloc.dart';

abstract class SocketState  extends Equatable{
  final String? idUser;
  SocketState(this.idUser);
  @override
  List<Object?> get props => [idUser];
}

class SocketInitial extends SocketState {
  SocketInitial(String? idUser) : super(idUser);
  @override
  List<Object> get props => [];
}

class SocketConnecting extends SocketState {
  SocketConnecting(String? idUser) : super(idUser);
  @override
  List<Object> get props => [];
}

class SocketConnected extends SocketState {
  SocketConnected(String? idUser) : super(idUser);
  @override
  List<Object> get props => [];
}

class SocketJoined extends SocketState {
  final String roomName;
  final List users;
  SocketJoined(String? idUser,this.roomName, this.users) : super(idUser);
  @override
  List<Object> get props => [roomName, users];
}

class SocketDisconnected extends SocketState {
  SocketDisconnected(String? idUser) : super(idUser);
  @override
  List<Object> get props => [];
}

class SocketError extends SocketState {
  final String error;
  SocketError(String? idUser,this.error) : super(idUser);
  @override
  List<Object> get props => [error];
}

class SocketRoomCreated extends SocketState {
  final String userName;
  final int avatar;
  SocketRoomCreated(String? idUser,this.userName, this.avatar, ):super(idUser);
  @override
  List<Object> get props => [userName, avatar];
}

class SocketQuestion extends SocketState {
  final Question;
  final int currentQuestion;
  SocketQuestion(String? idUser, this.Question, this.currentQuestion) : super(idUser);
  @override
  List<Object> get props => [Question];
}


class SocketLaunchTimer extends SocketState {
  final Question question;
  final bool creator;
  final int currentQuestion;
  SocketLaunchTimer(String? idUser, this.question, this.creator, this.currentQuestion): super(idUser);
  @override
  List<Object> get props => [Question];
}
