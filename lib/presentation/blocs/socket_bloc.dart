import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../data/models/questions.dart';


part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
   IO.Socket? socket;
  SocketBloc() : super(SocketInitial()) {
   on<SocketOnJoin>(_onJoined);
   on<SocketOnConnect>(_onConnect);
   on<SocketOnCreation>(_onCreation);
   on<SocketOnCreateRoom>(_onCreateRoom);
   on<SocketOnDisconnect>(_onDisconnected);
   on<SocketOnLaunchGame>(_onLaunchGame);
   on<SocketOnQuestion>(_onQuestion);

   add(SocketOnConnect());
}

  void _onConnect(SocketOnConnect event, Emitter<SocketState> emit) async {
    try {
      emit(SocketConnecting());
      socket = IO.io('http://localhost:3000', <String, dynamic>{
        'transports': ['websocket'],
      });
      emit(SocketConnected());
      print('connect on localhost:3000');
    } catch (e) {
      emit(SocketError(e.toString()));
    }
  }

  void _onJoined(SocketOnJoin event, Emitter<SocketState> emit) async {
    try {
      socket?.emit('join', {event.roomName, event.userName, event.avatar});
      _setupSocketListeners();
      print('join');
    } catch (e) {
      emit(SocketError(e.toString()));
    }
  }
  // Select if it create a room or join a room
  void _onCreation(SocketOnCreation event, Emitter<SocketState> emit) async {
    try {
      emit(SocketRoomCreated(event.typeCreation, event.userName, event.avatar));
      _setupSocketListeners();
      print('creation');
    } catch (e) {
      emit(SocketError(e.toString()));
    }
  }

  // Create room
   void _onCreateRoom(SocketOnCreateRoom event, Emitter<SocketState> emit) async {
     try {
       socket?.emit('createRoom', {event.uidQuizz, event.userName, event.avatar});
       emit(SocketRoomCreated(event.uidQuizz, event.userName, event.avatar));
       print('create room');
     } catch (e) {
       emit(SocketError(e.toString()));
     }
   }

  void _onDisconnected(SocketOnDisconnect event, Emitter<SocketState> emit) async {
    try {
      socket?.disconnect();
      emit(SocketDisconnected());
      print('disconnect');
    } catch (e) {
      emit(SocketError(e.toString()));
    }
  }

  void _onLaunchGame(SocketOnLaunchGame event, Emitter<SocketState> emit) async {
    try {
      socket?.emit('startGame', event.room);
      // emit(SocketLaunchGame());
      print('launch game');
    } catch (e) {
      emit(SocketError(e.toString()));
    }
  }

   void _onQuestion(SocketOnQuestion event, Emitter<SocketState> emit) async {
     try {
       emit(SocketQuestion(event.question));
     } catch (e) {
       emit(SocketError(e.toString()));
     }
   }

   void _setupSocketListeners() {
     socket?.on('roomData', (data) {
       print(data);
       emit(SocketJoined(data["roomId"], data["players"]));
     });

     socket?.on('startGame', (data) {
       print(data);
       print('game started');
       var question = Question.fromMap(data["question"]);
       emit(SocketLaunchGame(question));
     });

     // You can listen to more events here
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