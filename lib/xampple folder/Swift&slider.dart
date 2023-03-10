import 'package:flutter/material.dart';

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

  var j = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // info = "Bienvenue sur le tuto";
  }
  void change1(bool s){
    setState(() {
      val1 = s;
    });
  }
  void change2(bool t){
    setState(() {
      val2 = t;
    });
  }
  void change3(double f){
    setState(() {
      val3 = f;
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
            Switch(value: val1, onChanged: change1, activeColor: Colors.green,),

            SwitchListTile(value: val2, onChanged: change2, activeColor: Colors.blue,
              title: Text("Cameroun"),
              subtitle: Text("Yaoundé"),),
            Slider(value: val3, onChanged: change3)
          ],
        ),
      ),
    );
  }
}
