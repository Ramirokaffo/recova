import 'package:projet_flutter2/socket_events.dart';

import 'socket_service.dart';
class TimerService {

  static startServerTimer(int duration){
if (SocketService.socket!.connected) {
  SocketService.socket!.emit(TimerEvents.timerStart.toString().split(".").last,
      {"dur": duration,
      });
  } else {
  print("No socket connection found.");
}
  }
  
  static stopServerTimer(){
    if (SocketService.socket!.connected) {
      SocketService.socket!.emit(TimerEvents.timerStop.toString().split(".").last);
    } else {
      print("No socket connection found.");
    }
  }
}