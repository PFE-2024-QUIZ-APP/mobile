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

   add(SocketOnConnect());
}

  void _onConnect(SocketOnConnect event, Emitter<SocketState> emit) async {
    try {
      emit(SocketConnecting());
      socket = IO.io('http://localhost:3000', <String, dynamic>{
        'transports': ['websocket'],
      });
      emit(SocketConnected());
      print('connect');
    } catch (e) {
      emit(SocketError(e.toString()));
    }
  }

  void _onJoined(SocketOnJoined event, Emitter<SocketState> emit) async {
    try {
      socket?.emit('join', event.room);
      _setupSocketListeners();
      emit(SocketJoined(event.room));
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

   void _setupSocketListeners() {
     socket?.on('roomData', (data) {
       // print(data);
       add(SocketOnMessageReceived(data));
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
  final String message;

  SocketOnMessageReceived(this.message);
}