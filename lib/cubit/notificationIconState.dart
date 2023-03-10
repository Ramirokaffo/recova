import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class NotificationIconState extends Cubit<int> {
  // int notificationCount = 0;

  NotificationIconState(int state): super(state);
  void changeNotificationCount(int newCount) {
    emit(newCount);
    // notificationCount = newCount;
    // notifyListeners();
  }

}