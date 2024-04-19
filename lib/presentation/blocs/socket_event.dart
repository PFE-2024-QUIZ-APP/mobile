part of 'socket_bloc.dart';

abstract class SocketEvent {}


class Room {
  final String roomName;
  final String playerName;
  Room(this.roomName, this.playerName);
}
class SocketOnJoin extends SocketEvent {
  final String roomName;
  final String userName;
  final int avatar;
  SocketOnJoin(this.roomName, this.userName, this.avatar);
}

class SocketOnCreation extends SocketEvent {
  final String typeCreation;
  final String userName;
  final int avatar;
  SocketOnCreation(this.typeCreation, this.userName, this.avatar);
}

class SocketOnCreateRoom extends SocketEvent {
  final String userName;
  final int avatar;
  SocketOnCreateRoom( this.userName, this.avatar);
}

class SocketOnChangeTheme extends SocketEvent {
  final String uidQuizz;
  SocketOnChangeTheme(this.uidQuizz);
}


class SocketOnLaunchGame extends SocketEvent {
  final String room;
  SocketOnLaunchGame(this.room);
}

class SocketOnQuestion extends SocketEvent {
  final Question question;
  final bool creator;
  SocketOnQuestion(this.question, this.creator);
}

class SocketOnConnect extends SocketEvent {}

class SocketOnDisconnect extends SocketEvent {}


