part of 'socket_bloc.dart';

abstract class SocketEvent {}

class SocketOnJoined extends SocketEvent {
  final String room;
  SocketOnJoined(this.room);
}

class SocketOnConnect extends SocketEvent {}

class SocketOnDisconnect extends SocketEvent {}


