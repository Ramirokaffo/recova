// import 'dart:io';
import 'package:projet_flutter2/RoutesFile.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'stream_socket.dart';
import 'socket_events.dart';
// import 'stream_socket.dart';

class SocketService {
  static Socket? socket;

  static connectAndListenToSocket(String authToken, String deviceId, int id) {
  socket = io(
    "http://$uri",
    OptionBuilder()
        .setTransports(["websocket"])
        .setAuth({
      "token": 'Brearer $authToken',
    })
      .setQuery({
      "deviceId": deviceId,
      "id": id
    })
    // .setExtraHeaders({'Connection': 'upgrade', 'Upgrade': 'websocket'})
      .disableAutoConnect()
      .build()
  );
  // socket?.connected;

  if (!socket!.connected) {
    socket!.connect();
    print("Connecting...");
  }
  socket!.onConnect((_) {
    // print("Voici data de connect: ${_}");
    print("Connected and listening to socket.");
  });
  socket!.onDisconnect((_) => print("Disconnected from socket."));

  socket!.onError((data) => print(data));

  socket!.onConnectError((data) => {print(data)});

  socket!.on(TimerEvents.tick.toString().split(".").last, (data) {
    streamSocket.addResponse(data["timer"].toString());
    // TimerEvents.
  });

  }

 static disconnectSocket() {
socket!.disconnect();
  }

  static disposeSocket() {
socket!.dispose();
  }
}