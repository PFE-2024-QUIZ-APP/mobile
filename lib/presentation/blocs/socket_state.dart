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

class SocketCreationRoom extends SocketState {
  final String typeCreation;
  final String userName;
  SocketCreationRoom(this.typeCreation, this.userName);
  @override
  List<Object> get props => [typeCreation, userName];
}
