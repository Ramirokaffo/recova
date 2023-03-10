import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class TitleState extends ChangeNotifier {
  String pageTitle = "Tout";
  void changeTitle(String newTitle) {
    pageTitle = newTitle;
    notifyListeners();
  }
}