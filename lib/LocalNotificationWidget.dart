

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

  Future<void> showNoSoundNotification(
      FlutterLocalNotificationsPlugin notificationsPlugin,
      {required int id, required String title, required String body, required NotificationDetails type, int? seconds}) async {
    _showNotification(notificationsPlugin, id: id, title: title, body: body, type: noSoundType);
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



  NotificationDetails get noSoundType {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails("channelId", "channelName",
        channelDescription: "description",
        importance: Importance.max,
        priority: Priority.max,
        playSound: false,
        ongoing: true,
        autoCancel: false,
    // actions: [
    //   AndroidNotificationAction("2", "title", inputs: [AndroidNotificationActionInput(label: "Action", allowFreeFormInput: true, choices: ["toto", "tata", "tutu"])])
    // ]
    );
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();
    return const NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
  }


  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }


  Future onselectNotification() async {
    print("selectionnee");
    await Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePerduPage(),));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings("@mipmap/ic_launcher");

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("notifcations"),
            TextButton(onPressed: (){
              showOnGoingNotification(flutterLocalNotificationsPlugin, id: 1, title: "title", body: "body", type: onGoingType);
            }, child: const Text("Show notification")),
            const Text("notifcations Silencieuses"),
            TextButton(onPressed: (){
              showNoSoundNotification(flutterLocalNotificationsPlugin, id: 2, title: "title", body: "body", type: onGoingType);
            }, child: const Text("Show silent notification")),
            const SizedBox(height: 50,),
            TextButton(onPressed: (){
              showNoSoundNotification(flutterLocalNotificationsPlugin, id: 1, title: "othertitle", body: "otherbody", type: onGoingType);
            }, child: const Text("modifier notification")),
            const SizedBox(height: 50,),
            const Text("modifier"),
            TextButton(onPressed: (){
              cancelAllNotifications();
              }, child: const Text("Cancel all notification")),
            const SizedBox(height: 50,),
          ],
        ));
  }

}