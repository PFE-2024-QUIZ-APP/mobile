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
   on<SocketOnDisconnect>(_onDisconnected);
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
     // print("ABDE ${event.avatar}");
      //print("ABDE ${event.room.roomName}");
      socket?.emit('join', event);
      emit(SocketJoined(event.roomName, event.userName, event.avatar));
      print('join');
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


  @override
  Future<void> close() {
    socket?.dispose();
    return super.close();
  }
}