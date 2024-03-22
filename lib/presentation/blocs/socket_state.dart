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
  final String userName;
  final String avatar;
  SocketJoined(this.roomName, this.userName, this.avatar);
  @override
  List<Object> get props => [roomName, userName, avatar];
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

