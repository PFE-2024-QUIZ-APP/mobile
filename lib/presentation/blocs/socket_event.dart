part of 'socket_bloc.dart';

abstract class SocketEvent {}


class Room {
  final String roomName;
  final String playerName;
  Room(this.roomName, this.playerName);
}
class SocketOnJoined extends SocketEvent {
  final String roomName;
  final String userName;
  final String avatar;
  SocketOnJoined(this.roomName, this.userName, this.avatar);
}

class SocketOnCreation extends SocketEvent {
  final String typeCreation;
  final String userName;
  SocketOnCreation(this.typeCreation, this.userName);
}

class SocketOnConnect extends SocketEvent {}

class SocketOnDisconnect extends SocketEvent {}


