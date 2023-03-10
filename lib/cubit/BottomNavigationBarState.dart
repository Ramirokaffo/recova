
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class BottomNavigationBarState extends Cubit<bool> {
  // int notificationCount = 0;

  BottomNavigationBarState(bool state): super(state);
  void changeNotificationCount(bool isVisible) {
    emit(isVisible);
    // notificationCount = newCount;
    // notifyListeners();
  }

}