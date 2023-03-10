import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: soir()
    );
  }
}
class soir extends StatefulWidget {
  @override
  _soirState createState() => _soirState();
}

class _soirState extends State<soir> {
  var info = "Bienvenue sur l'application de ramiro";
  var welcome = "Bienvenue sur mon application";
  bool val1 = false;
  bool val2 = false;
  double val3 = 0.0;
  String _val = "";

  var j = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // info = "Bienvenue sur le tuto";
  }
Future _select_full_date() async {
DateTime? picker = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2018),
    lastDate: DateTime(2028)
);
if (picker != null) setState(() {
  _val = picker.toString();
});
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("La date choisie c'est : $_val"),
            RaisedButton(
                onPressed: _select_full_date,
            child: Text("Cliquez ici"),)

          ],
        ),
      ),
    );
  }
}
