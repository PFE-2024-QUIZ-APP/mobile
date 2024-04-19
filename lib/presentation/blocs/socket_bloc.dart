import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../data/models/questions.dart';


part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
   IO.Socket? socket;
   String? idUser;


  SocketBloc() : super(SocketInitial("")) {
   on<SocketOnJoin>(_onJoined);
   on<SocketOnAnswerQuestion>(_onAnswerQuestion);
   on<SocketOnConnect>(_onConnect);
   on<SocketOnCreation>(_onCreation);
   on<SocketOnCreateRoom>(_onCreateRoom);
   on<SocketOnDisconnect>(_onDisconnected);
   on<SocketOnLaunchGame>(_onLaunchGame);
   on<SocketOnChangeTheme>(_onChangeTheme);
   on<SocketOnQuestion>(_onQuestion);
   on<SocketOnNextQuestion>(_onNextQuestion);
   add(SocketOnConnect());
}

  void _onConnect(SocketOnConnect event, Emitter<SocketState> emit) async {
    try {
      emit(SocketConnecting(idUser));
      socket = IO.io('http://localhost:3000', <String, dynamic>{
        'transports': ['websocket'],
      });
      _setupSocketListeners();
      print(idUser);
      print('idUser');
      print('connect on localhost:3000');
    } catch (e) {
      emit(SocketError(idUser,e.toString()));
    }
  }

   void _onChangeTheme(SocketOnChangeTheme event, Emitter<SocketState> emit) async {
     try {
       print('change theme');
       print(event.uidQuizz);
       socket?.emit('editRoom', {event.uidQuizz});
     } catch (e) {
       emit(SocketError(idUser,e.toString()));
     }
   }

  void _onJoined(SocketOnJoin event, Emitter<SocketState> emit) async {
    try {
      print(event.roomName);
      var object = {
        "room": event.roomName,
        "userName": event.userName,
        "avatar": event.avatar
      };
      socket?.emit('join', object);
      _setupSocketListeners();
      print('join');
    } catch (e) {
      emit(SocketError(idUser,e.toString()));
    }
  }
  // Select if it create a room or join a room
  void _onCreation(SocketOnCreation event, Emitter<SocketState> emit) async {
    try {
      emit(SocketRoomCreated(idUser,event.userName, event.avatar));
      _setupSocketListeners();
      print('creation');
    } catch (e) {
      emit(SocketError(idUser,e.toString()));
    }
  }

   void _onAnswerQuestion(SocketOnAnswerQuestion event, Emitter<SocketState> emit)  {
     try {
       socket?.emit('responsePlayer', {
         "indexQuestion": event.currentQuestion,
         "response": event.answer,
       });
       _setupSocketListeners();
       print('creation');
     } catch (e) {
       emit(SocketError(idUser,e.toString()));
     }
   }

  // Create room
   void _onCreateRoom(SocketOnCreateRoom event, Emitter<SocketState> emit) async {
     try {
       var object = {
         "userName": event.userName,
         "avatar" : event.avatar
       };
       socket?.emit('createRoom', object);
       _setupSocketListeners();
       // Peut être mettre un loader ici pour attendre la réponse du serveur
       print('create room');
     } catch (e) {
       emit(SocketError(idUser,e.toString()));
     }
   }

  void _onDisconnected(SocketOnDisconnect event, Emitter<SocketState> emit) async {
    try {
      socket?.disconnect();
      emit(SocketDisconnected(idUser));
      print('disconnect');
    } catch (e) {
      emit(SocketError(idUser,e.toString()));
    }
  }

  void _onLaunchGame(SocketOnLaunchGame event, Emitter<SocketState> emit) async {
    try {
      socket?.emit('nextQuestion');
      print('launch game');
    } catch (e) {
      emit(SocketError(idUser,e.toString()));
    }
  }

   void _onNextQuestion (SocketOnNextQuestion event, Emitter<SocketState> emit) async {
     try {
       socket?.emit('nextQuestion');
       print('next Question');
     } catch (e) {
       emit(SocketError(idUser,e.toString()));
     }
   }

   void _onQuestion(SocketOnQuestion event, Emitter<SocketState> emit) async {
     try {
       emit(SocketQuestion(idUser,event.question, event.currentQuestion));
     } catch (e) {
       emit(SocketError(idUser,e.toString()));
     }
   }

   void _setupSocketListeners() {
     socket?.on('id', (data) {
       print(data);
       idUser = data;
       emit(SocketConnected(idUser));
     });

     socket?.on('roomData', (data) {
       print(data);
       emit(SocketJoined(idUser,data["roomId"], data["players"]));
     });

     socket?.on('nextQuestion', (data) {
       print(data["creator"]);
       print(socket?.id);
       print('game started');
       var creator = data["creator"] == socket?.id;
       var currentQuestion = data["currentQuestion"];
       var question = Question.fromMap(data["question"]);
       emit(SocketLaunchTimer(idUser,question, creator,currentQuestion));
     });

     socket?.on('roomNotFound', (data) {
       print(data);
     });
   }

  @override
  Future<void> close() {
    socket?.dispose();
    return super.close();
  }
}

class SocketOnMessageReceived extends SocketEvent {
  final List<dynamic> message;

  SocketOnMessageReceived(this.message);
}