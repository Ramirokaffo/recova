import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:projet_flutter2/HomePerduPage.dart';
import 'package:rxdart/subjects.dart';




class  RealNotificationService {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  // InitializationSettings initializationSettings =
  // InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsIOS
  // );

  // Future showOnGoingNotification()
  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/ic_laucher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) {
          print("L'id: $id");
        },
        // onDidReceiveLocalNotification





    );
    InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin
    );
    //opieouiguqdhkjsk
    await flutterLocalNotificationsPlugin.initialize(initializationSettings
        , onDidReceiveNotificationResponse: onNotificationSelect,);
    // flutterLocalNotificationsPlugin.
  }

  // Future<NotificationDetails> _no

  Future<void> _showNotification(
      FlutterLocalNotificationsPlugin notificationsPlugin,
      {required int id,
        required String title,
        required String body,
        required NotificationDetails type, int? seconds}) async {
    notificationsPlugin.show(id, title, body, type);
    // notificationsPlugin.
    // notificationsPlugin.
  }

  Future<void> showNoSoundNotification(
      FlutterLocalNotificationsPlugin notificationsPlugin,
      {required int id,
        required String title,
        required String body,
        required NotificationDetails type, int? seconds}) async {
    _showNotification(notificationsPlugin, id: id, title: title, body: body, type: noSoundType);
  }

  Future<void> showOnGoingNotification(
      {required int id,
        required String title,
        required String body,
        NotificationDetails? type,
        int? seconds}) async {
    _showNotification(flutterLocalNotificationsPlugin, id: id, title: title, body: body, type: onGoingType);
  }


  NotificationDetails get onGoingType {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails("channelId", "channelName",
        channelDescription: "description",
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        ongoing: true,
        // autoCancel: false,
    timeoutAfter: 50,
        // usesChronometer: true,
      actions: [AndroidNotificationAction("1", "Clique", inputs: [AndroidNotificationActionInput()])]
    );
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


  Future onselectNotification(BuildContext context) async {
    print("selectionnee");
    await Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePerduPage(),));
  }

  void onNotificationSelect(NotificationResponse? notificationResponse) {
    print("Le payload ici: ${notificationResponse!.payload}");
    if (notificationResponse.payload != null && notificationResponse.payload!.isNotEmpty) {
      onNotificationClick.add(notificationResponse.payload);
    }
  }



  void showNotificationWithPayload(
      {
    required int id,
    required String title,
    required String body,
    required String payload
      }) {
    _showNotification(flutterLocalNotificationsPlugin, id: id, title: title, body: body, type: onGoingType, );

  }



}