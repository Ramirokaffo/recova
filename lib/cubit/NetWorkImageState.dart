
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class NetWorkImageState extends Cubit<String> {
  // int notificationCount = 0;

  NetWorkImageState(String state): super(state);
  void changeNotificationCount(String imageLink) {
    emit(imageLink);
    // notificationCount = newCount;
    // notifyListeners();
  }

}