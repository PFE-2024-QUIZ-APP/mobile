import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
   IO.Socket? socket;
  SocketBloc() : super(SocketInitial()) {
   on<SocketOnJoined>(_onJoined);
   on<SocketOnConnect>(_onConnect);
   on<SocketOnCreation>(_onCreation);
   on<SocketOnDisconnect>(_onDisconnected);

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

  void _onJoined(SocketOnJoined event, Emitter<SocketState> emit) async {
    try {
      print(event.userName);
      socket?.emit('join', {event.roomName, event.userName, event.avatar});
      _setupSocketListeners();
      print('join');
    } catch (e) {
      emit(SocketError(e.toString()));
    }
  }

  void _onCreation(SocketOnCreation event, Emitter<SocketState> emit) async {
    try {
      emit(SocketCreationRoom(event.typeCreation, event.userName));
      print('creation');
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

   void _setupSocketListeners() {
     socket?.on('roomData', (data) {
       print(data);
       emit(SocketJoined(data["roomId"], data["players"]));
       // add(SocketOnMessageReceived(data));
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