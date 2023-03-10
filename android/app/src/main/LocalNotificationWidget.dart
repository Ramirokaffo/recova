

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:projet_flutter2/HomePerduPage.dart';

class LocalNotificationWidget extends StatefulWidget {
  const LocalNotificationWidget({super.key});

  @override

    _LocalNotificationWidgetState createState() => _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();



  // InitializationSettings initializationSettings =
  // InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsIOS
  // );

  // Future showOnGoingNotification()

  Future<void> _showNotification(
      FlutterLocalNotificationsPlugin notificationsPlugin,
      {required int id, required String title, required String body, required NotificationDetails type, int? seconds}) async {
   notificationsPlugin.show(id, title, body, type);
  }

  Future<void> showOnGoingNotification(
      FlutterLocalNotificationsPlugin notificationsPlugin,
      {required int id, required String title, required String body, required NotificationDetails type, int? seconds}) async {
    _showNotification(notificationsPlugin, id: id, title: title, body: body, type: onGoingType);
  }


  NotificationDetails get onGoingType {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails("channelId", "channelName",
        channelDescription: "description",
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
    ongoing: true,
    autoCancel: false);
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();
    return const NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
  }


  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }


  Future onselectNotification() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePerduPage(),));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings("ic_launcher");

    DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) => onselectNotification(),
    );
    flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS));

  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
          child: Column(
            children: [
              Text("notifcations"),
              TextButton(onPressed: (){
                showOnGoingNotification(flutterLocalNotificationsPlugin, id: 1, title: "title", body: "body", type: onGoingType);
              }, child: Text("Show notification"))
            ],
          ),
        ));
  }

}