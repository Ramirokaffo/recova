import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:projet_flutter2/ConstantFile.dart';
import 'package:projet_flutter2/LocalBdManagerFile.dart';
import 'package:projet_flutter2/RealNotificationService.dart';
import 'package:projet_flutter2/cubit/notificationIconState.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/socket_service.dart';
import 'package:projet_flutter2/stream_socket.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:projet_flutter2/timer_service.dart';
import 'package:provider/provider.dart';
import 'package:projet_flutter2/MiniFunctionFile.dart';

// void main() {
//   print("toto");
//   // runApp(const MyApp());
//
//   void didi(){
//     print("hj");
//   }
//   didi();
//
//
//
//
// }
//




class MyAppSocketTest extends StatelessWidget {
  const MyAppSocketTest({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  RealNotificationService realNotificationService = RealNotificationService();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


String _convertToDisplayTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  if (duration.inHours == 0) {
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

@override
void initState() {
  realNotificationService.initialize();
  super.initState();


}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (SocketService.socket != null && SocketService.socket!.connected)?
                StreamBuilder(
                  stream: streamSocket.getResponse,
                    builder: (context, snapshot) {
                    print(snapshot.data.toString());
                      if (snapshot.hasData) {
                        if (snapshot.data.toString() == "0") {
                          return const Text("Socket status: TICKING TIMEOUT");
                        } else {
                          return Text("Socket status: TIMER TICKING - "
                              "${_convertToDisplayTime(Duration(seconds: int.parse(snapshot.data.toString()))).toString()}");
                        }
                      } else {
                        if (SocketService.socket!.connected) {
                          return const Text("Socket Status: CONNECTED");
                        } else {
                          return const Text("Socket Status: DISCONNECTED");

                        }
                      }
                    },): const Text("Socket Status: DISCONNECTED"),
            ElevatedButton.icon(onPressed: () async {
              String? id = await getId();
              print("voici d'id: $id");
              print("${await localBdSelectSetting("token")}");
              print(oneUserDataDico);
              if (oneUserDataDico.isEmpty) {
                // pendingPageFunction(context);
                await getOneUserDataById();
                // Navigator.of(context).pop();
                // showFooterUserAccountInfo(context);
              }

              SocketService.connectAndListenToSocket(await localBdSelectSetting("token"), id!, oneUserDataDico["id"]);
              SocketService.socket!.onAny((event, data) {
                // setState(() {});
                // showOnGoingNotification(flutterLocalNotificationsPlugin, id: 1, title: "title", body: "body", type: onGoingType);

                realNotificationService.showOnGoingNotification(id: 1, title: "title", body: "body");
                print(data);
                // context.read<NotificationIconState>().changeNotificationCount(data);

              });
            }, icon: const Icon(Icons.connect_without_contact_rounded),
                style: ElevatedButton.styleFrom(primary: Colors.purple),
                label: const Text("Connect Socket")),

            ElevatedButton.icon(onPressed: () async {
              TimerService.startServerTimer(500);
            }, icon: const Icon(Icons.timer),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[900]),
                label: const Text("Start Server Countdown")),
            ElevatedButton.icon(onPressed: () async {
              TimerService.stopServerTimer();
            }, icon: const Icon(Icons.timer_off),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
                label: const Text("Stop Server Countdown")),

            ElevatedButton.icon(onPressed: () async {
              SocketService.disconnectSocket();
            }, icon: const Icon(Icons.remove_done),
                style: ElevatedButton.styleFrom(primary: Colors.purple),
                label: const Text("Disconnect the socket\n (Does not remove te listeners")),

            ElevatedButton.icon(onPressed: () async {
              SocketService.disposeSocket();
            }, icon: const Icon(Icons.cancel),
                style: ElevatedButton.styleFrom(primary: Colors.purple),
                label: const Text("Dispose socket\n (Fresh Start - removes all listeners")),

          ],
        ),
      ),
    );
  }
}
