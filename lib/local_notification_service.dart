// import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:projet_flutter2/notificationservice.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:rxdart/rxdart.dart';

class LocalNotificationService {
  LocalNotificationService();

 static final _localNotificationService = FlutterLocalNotificationsPlugin();

static  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@drawable/ic_stat_remove_red_eye");
    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    final InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);
    await _localNotificationService.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse:
          (NotificationResponse notificationResponse)  {
        print("object");
      },
    );
  }

 static Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channelId", "channelName",
            channelDescription: "description",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();
    return const NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
  }

static  Future<void> showNotification({
    required id,
    required String title,
    required body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

 static void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print("id: $id");
  }

  void onSelectNotification(String? payload) {
    print("payload: $payload");
  }
}
