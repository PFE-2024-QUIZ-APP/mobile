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

class SocketOnAnswerQuestion extends SocketEvent {
  final String answer;
  final int currentQuestion;
  SocketOnAnswerQuestion( this.answer, this.currentQuestion);
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

class SocketOnNextQuestion extends SocketEvent {
  SocketOnNextQuestion();
}

class SocketOnRestart extends SocketEvent {
  SocketOnRestart();
}

class SocketOnQuestion extends SocketEvent {
  final Question question;
  final bool creator;
  final int currentQuestion;
  final List responsesPlayers;
  SocketOnQuestion(this.question, this.creator, this.currentQuestion, this.responsesPlayers);
}

class SocketOnConnect extends SocketEvent {}

class SocketOnDisconnect extends SocketEvent {}


